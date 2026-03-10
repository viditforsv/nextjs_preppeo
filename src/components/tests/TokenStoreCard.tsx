'use client';

import { useState } from 'react';
import { Loader2, ShoppingCart } from 'lucide-react';
import type { TokenPackWithExam } from '@/types/test-tokens';

declare global {
  interface Window {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    Razorpay: any;
  }
}

interface TokenStoreCardProps {
  pack: TokenPackWithExam;
  onPurchaseComplete: (tokens: string[]) => void;
}

function loadRazorpayScript(): Promise<boolean> {
  if (window.Razorpay) return Promise.resolve(true);
  return new Promise((resolve) => {
    const script = document.createElement('script');
    script.src = 'https://checkout.razorpay.com/v1/checkout.js';
    script.onload = () => resolve(true);
    script.onerror = () => resolve(false);
    document.body.appendChild(script);
  });
}

export default function TokenStoreCard({ pack, onPurchaseComplete }: TokenStoreCardProps) {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const pricePerToken = (pack.price / pack.token_count).toFixed(0);

  const handleBuy = async () => {
    setLoading(true);
    setError('');

    try {
      // 1. Create order
      const orderRes = await fetch('/api/tests/create-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ packId: pack.id }),
      });
      const orderData = await orderRes.json();

      if (!orderData.success) {
        setError(orderData.error || 'Failed to create order');
        setLoading(false);
        return;
      }

      // 2. Open Razorpay
      const loaded = await loadRazorpayScript();
      if (!loaded) {
        setError('Failed to load payment gateway');
        setLoading(false);
        return;
      }

      const razorpay = new window.Razorpay({
        key: process.env.NEXT_PUBLIC_RAZORPAY_KEY_ID,
        amount: orderData.amount * 100,
        currency: orderData.currency,
        name: 'Preppeo',
        description: orderData.packName,
        order_id: orderData.orderId,
        theme: { color: '#1a365d' },
        handler: async (response: { razorpay_payment_id: string; razorpay_signature: string }) => {
          // 3. Verify payment
          const verifyRes = await fetch('/api/tests/verify-payment', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              orderId: orderData.orderId,
              paymentId: response.razorpay_payment_id,
              signature: response.razorpay_signature,
              purchaseId: orderData.purchaseId,
            }),
          });
          const verifyData = await verifyRes.json();

          if (verifyData.success) {
            onPurchaseComplete(verifyData.tokens);
          } else {
            setError(verifyData.error || 'Payment verification failed');
          }
          setLoading(false);
        },
        modal: {
          ondismiss: () => {
            setLoading(false);
          },
        },
      });

      razorpay.open();
    } catch {
      setError('Something went wrong');
      setLoading(false);
    }
  };

  return (
    <div className="bg-white border border-gray-200 rounded-xl p-5 hover:shadow-md transition-shadow">
      <div className="flex items-start justify-between mb-2">
        <div>
          <h4 className="font-bold text-gray-900">{pack.name}</h4>
          <p className="text-xs text-gray-500">{pack.exam_types.name}</p>
        </div>
        <div className="text-right">
          <div className="text-lg font-bold text-[#1a365d]">
            ₹{pack.price}
          </div>
          <div className="text-xs text-gray-400">₹{pricePerToken}/test</div>
        </div>
      </div>

      <div className="text-sm text-gray-600 mb-4">
        {pack.token_count} mock test {pack.token_count === 1 ? 'token' : 'tokens'}
      </div>

      {error && <p className="text-xs text-red-600 mb-2">{error}</p>}

      <button
        onClick={handleBuy}
        disabled={loading}
        className="w-full flex items-center justify-center gap-2 py-2.5 bg-[#1a365d] text-white text-sm font-semibold rounded-lg hover:bg-[#2a4a7f] disabled:opacity-60 transition-colors"
      >
        {loading ? (
          <Loader2 className="w-4 h-4 animate-spin" />
        ) : (
          <>
            <ShoppingCart className="w-4 h-4" />
            Buy Now
          </>
        )}
      </button>
    </div>
  );
}
