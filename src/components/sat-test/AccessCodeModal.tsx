'use client';

import { useState } from 'react';
import { X, Loader2, KeyRound } from 'lucide-react';

interface AccessCodeModalProps {
  onSuccess: (setNumber: number, tokenCode: string) => void;
  onClose: () => void;
}

export default function AccessCodeModal({ onSuccess, onClose }: AccessCodeModalProps) {
  const [code, setCode] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!code.trim()) {
      setError('Please enter an access code');
      return;
    }

    setLoading(true);
    setError('');

    try {
      const res = await fetch('/api/tests/verify-token', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ code: code.trim(), examType: 'sat' }),
      });

      const data = await res.json();

      if (data.valid) {
        onSuccess(data.setNumber, code.trim());
      } else {
        setError(data.message || 'Invalid access code');
      }
    } catch {
      setError('Something went wrong. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
      <div className="w-full max-w-md bg-white rounded-xl shadow-2xl">
        <div className="flex items-center justify-between border-b px-6 py-4">
          <div className="flex items-center gap-2">
            <KeyRound className="w-5 h-5 text-[#0d47a1]" />
            <h2 className="text-lg font-semibold text-gray-900">Enter Access Code</h2>
          </div>
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-gray-600 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-6 space-y-4">
          <p className="text-sm text-gray-600">
            Enter the access code to begin the SAT test. Free code: <code className="font-mono font-semibold text-[#0d47a1]">SAT-FREE-SET1</code>
          </p>

          <input
            type="text"
            value={code}
            onChange={(e) => {
              setCode(e.target.value);
              if (error) setError('');
            }}
            placeholder="e.g. SAT-FREE-SET1"
            autoFocus
            className="w-full px-4 py-3 border-2 border-gray-200 rounded-lg text-center text-lg tracking-widest font-mono focus:border-[#0d47a1] focus:outline-none transition-colors"
          />

          {error && (
            <p className="text-sm text-red-600 text-center">{error}</p>
          )}

          <button
            type="submit"
            disabled={loading}
            className="w-full py-3 bg-[#0d47a1] text-white font-semibold rounded-lg hover:bg-[#1565c0] disabled:opacity-60 transition-colors flex items-center justify-center gap-2"
          >
            {loading ? (
              <>
                <Loader2 className="w-4 h-4 animate-spin" />
                Verifying...
              </>
            ) : (
              'Start Test'
            )}
          </button>
        </form>
      </div>
    </div>
  );
}
