'use client';

import { useState } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { Loader2, Mail, Lock, User, ChevronRight } from 'lucide-react';

const SAT_DATE_OPTIONS = [
  'Within 1 month',
  '1–3 months',
  '3–6 months',
  '6+ months',
  'Just exploring',
] as const;

// sessionStorage flag set before a Google OAuth redirect so the results screen
// knows to resume the claim + attempt-save when the user returns.
export const RESULTS_CLAIM_FLAG = 'sat-results-claim';

interface FreeMockSignupCardProps {
  /** Called after a successful email signup (Google resumes via redirect). */
  onSignedUp: () => void;
  heading?: string;
  subheading?: string;
}

export default function FreeMockSignupCard({
  onSignedUp,
  heading = 'Create your free account',
  subheading = 'Sign up to unlock your full score report',
}: FreeMockSignupCardProps) {
  const { signUp, signInWithGoogle } = useAuth();

  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [satDate, setSatDate] = useState('');
  const [formError, setFormError] = useState('');
  const [formLoading, setFormLoading] = useState(false);

  async function handleEmailSignup(e: React.FormEvent) {
    e.preventDefault();
    setFormLoading(true);
    setFormError('');
    try {
      const fullName = `${firstName} ${lastName}`.trim();
      // Mark that the upcoming auth originated from the results-screen signup so
      // the results screen claims the free token + saves the attempt for it.
      sessionStorage.setItem(RESULTS_CLAIM_FLAG, '1');
      await signUp(email, password, fullName, 'student');
      onSignedUp();
    } catch (err) {
      sessionStorage.removeItem(RESULTS_CLAIM_FLAG);
      setFormError(err instanceof Error ? err.message : 'Signup failed');
      setFormLoading(false);
    }
  }

  async function handleGoogleSignup() {
    setFormLoading(true);
    setFormError('');
    try {
      sessionStorage.setItem(RESULTS_CLAIM_FLAG, '1');
      await signInWithGoogle('/sat-test');
    } catch (err) {
      setFormError(err instanceof Error ? err.message : 'Google signup failed');
      setFormLoading(false);
    }
  }

  return (
    <div className="bg-white rounded-2xl border border-gray-200 shadow-lg p-8">
      <h2 className="text-xl font-bold text-[#1a365d] mb-1">{heading}</h2>
      <p className="text-sm text-gray-500 mb-6">{subheading}</p>

      {/* Google OAuth */}
      <button
        type="button"
        onClick={handleGoogleSignup}
        disabled={formLoading}
        className="w-full flex items-center justify-center gap-3 px-4 py-3 bg-white border border-gray-200 rounded-lg hover:bg-gray-50 text-gray-700 font-medium transition-colors mb-4 disabled:opacity-50"
      >
        <svg className="h-5 w-5" viewBox="0 0 24 24">
          <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" />
          <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" />
          <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" />
          <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" />
        </svg>
        Continue with Google
      </button>

      <div className="relative my-5">
        <div className="absolute inset-0 flex items-center">
          <span className="w-full border-t border-gray-200" />
        </div>
        <div className="relative flex justify-center text-xs uppercase">
          <span className="bg-white px-2 text-gray-400">or sign up with email</span>
        </div>
      </div>

      <form onSubmit={handleEmailSignup} className="space-y-3">
        <div className="grid grid-cols-2 gap-3">
          <div>
            <label htmlFor="rs-first" className="text-xs font-medium text-gray-600 mb-1 block">First Name</label>
            <div className="relative">
              <User className="absolute left-3 top-2.5 h-4 w-4 text-gray-400" />
              <input
                id="rs-first"
                type="text"
                required
                value={firstName}
                onChange={(e) => setFirstName(e.target.value)}
                placeholder="First name"
                className="w-full pl-9 pr-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/20 focus:border-[#0d47a1]"
              />
            </div>
          </div>
          <div>
            <label htmlFor="rs-last" className="text-xs font-medium text-gray-600 mb-1 block">Last Name</label>
            <div className="relative">
              <User className="absolute left-3 top-2.5 h-4 w-4 text-gray-400" />
              <input
                id="rs-last"
                type="text"
                required
                value={lastName}
                onChange={(e) => setLastName(e.target.value)}
                placeholder="Last name"
                className="w-full pl-9 pr-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/20 focus:border-[#0d47a1]"
              />
            </div>
          </div>
        </div>

        <div>
          <label htmlFor="rs-email" className="text-xs font-medium text-gray-600 mb-1 block">Email</label>
          <div className="relative">
            <Mail className="absolute left-3 top-2.5 h-4 w-4 text-gray-400" />
            <input
              id="rs-email"
              type="email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="you@example.com"
              className="w-full pl-9 pr-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/20 focus:border-[#0d47a1]"
            />
          </div>
        </div>

        <div>
          <label htmlFor="rs-pass" className="text-xs font-medium text-gray-600 mb-1 block">Password</label>
          <div className="relative">
            <Lock className="absolute left-3 top-2.5 h-4 w-4 text-gray-400" />
            <input
              id="rs-pass"
              type="password"
              required
              minLength={6}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Min. 6 characters"
              className="w-full pl-9 pr-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/20 focus:border-[#0d47a1]"
            />
          </div>
        </div>

        <div>
          <label htmlFor="rs-date" className="text-xs font-medium text-gray-600 mb-1 block">When are you planning to take the SAT?</label>
          <select
            id="rs-date"
            value={satDate}
            onChange={(e) => setSatDate(e.target.value)}
            className="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-[#0d47a1]/20 focus:border-[#0d47a1] bg-white text-gray-700"
          >
            <option value="">Select...</option>
            {SAT_DATE_OPTIONS.map((opt) => (
              <option key={opt} value={opt}>{opt}</option>
            ))}
          </select>
        </div>

        {formError && (
          <p className="text-sm text-red-600 bg-red-50 border border-red-200 rounded-lg p-2 text-center">{formError}</p>
        )}

        <button
          type="submit"
          disabled={formLoading}
          className="w-full flex items-center justify-center gap-2 py-3 bg-[#0d47a1] text-white font-semibold rounded-lg hover:bg-[#1565c0] transition-colors disabled:opacity-50"
        >
          {formLoading ? (
            <Loader2 className="w-4 h-4 animate-spin" />
          ) : (
            <>
              Create Account & View Report
              <ChevronRight className="w-4 h-4" />
            </>
          )}
        </button>

        <p className="text-xs text-gray-400 text-center">
          Already have an account?{' '}
          <a href="/auth?redirect=/sat-test" className="text-[#0d47a1] hover:underline">Sign in</a>
        </p>
      </form>
    </div>
  );
}
