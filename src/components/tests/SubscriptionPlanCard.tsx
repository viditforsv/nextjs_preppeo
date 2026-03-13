'use client';

import { useState } from 'react';
import { Loader2, Crown, Sparkles, BookOpen, ClipboardList } from 'lucide-react';

declare global {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  interface Window { Razorpay: any }
}

interface Plan {
  id: string;
  name: string;
  plan_type: 'practice_only' | 'bundle';
  duration_days: number;
  mock_tokens_included: number;
  price: number;
  exam_type: string;
}

interface SubscriptionPlanCardProps {
  plan: Plan;
  onPurchaseComplete: (planName: string, tokens: string[]) => void;
}

export default function SubscriptionPlanCard({ plan, onPurchaseComplete }: SubscriptionPlanCardProps) {
  const [purchasing, setPurchasing] = useState(false);
  const isBundle = plan.plan_type === 'bundle';
  const months = Math.round(plan.duration_days / 30);

  const handlePurchase = async () => {
    setPurchasing(true);
    try {
      const orderRes = await fetch('/api/subscriptions/create-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ planId: plan.id }),
      });
      const orderData = await orderRes.json();
      if (!orderData.success) throw new Error(orderData.error);

      const options = {
        key: process.env.NEXT_PUBLIC_RAZORPAY_KEY_ID,
        amount: Math.round(plan.price * 100),
        currency: 'INR',
        name: 'Preppeo',
        description: plan.name,
        order_id: orderData.orderId,
        handler: async (response: { razorpay_order_id: string; razorpay_payment_id: string; razorpay_signature: string }) => {
          const verifyRes = await fetch('/api/subscriptions/verify-payment', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              orderId: response.razorpay_order_id,
              paymentId: response.razorpay_payment_id,
              signature: response.razorpay_signature,
              purchaseId: orderData.purchaseId,
              planId: plan.id,
            }),
          });
          const verifyData = await verifyRes.json();
          if (verifyData.success) {
            onPurchaseComplete(plan.name, verifyData.tokens ?? []);
          }
          setPurchasing(false);
        },
        modal: { ondismiss: () => setPurchasing(false) },
        theme: { color: '#0d47a1' },
      };

      const rzp = new window.Razorpay(options);
      rzp.open();
    } catch (err) {
      console.error('Subscription purchase error:', err);
      setPurchasing(false);
    }
  };

  return (
    <div className={`bg-white border rounded-xl p-5 hover:shadow-md transition-shadow ${
      isBundle ? 'border-[#0d47a1]/30 ring-1 ring-[#0d47a1]/10' : 'border-gray-200'
    }`}>
      <div className="flex items-start justify-between mb-3">
        <div>
          <div className="flex items-center gap-2">
            <h4 className="font-bold text-gray-900">{plan.name}</h4>
            {isBundle && (
              <span className="inline-flex items-center gap-1 px-2 py-0.5 bg-[#0d47a1]/10 text-[#0d47a1] text-xs font-bold rounded-full">
                <Sparkles className="w-3 h-3" />
                Best Value
              </span>
            )}
          </div>
          <p className="text-xs text-gray-500 mt-0.5">{months} month{months > 1 ? 's' : ''} access</p>
        </div>
        <div className="text-right">
          <p className="text-xl font-bold text-gray-900">₹{plan.price.toLocaleString('en-IN')}</p>
        </div>
      </div>

      <div className="space-y-2 mb-4">
        <div className="flex items-center gap-2 text-sm text-gray-600">
          <BookOpen className="w-4 h-4 text-emerald-600 shrink-0" />
          <span>Unlimited practice questions with AI explanations</span>
        </div>
        <div className="flex items-center gap-2 text-sm text-gray-600">
          <Crown className="w-4 h-4 text-amber-500 shrink-0" />
          <span>Full control over difficulty, domains, and question count</span>
        </div>
        {isBundle && plan.mock_tokens_included > 0 && (
          <div className="flex items-center gap-2 text-sm text-gray-600">
            <ClipboardList className="w-4 h-4 text-[#0d47a1] shrink-0" />
            <span className="font-medium">{plan.mock_tokens_included} full-length adaptive mock{plan.mock_tokens_included > 1 ? 's' : ''} included</span>
          </div>
        )}
      </div>

      <button
        onClick={handlePurchase}
        disabled={purchasing}
        className={`w-full py-2.5 font-semibold text-sm rounded-lg transition-colors disabled:opacity-60 ${
          isBundle
            ? 'bg-[#0d47a1] text-white hover:bg-[#1565c0]'
            : 'bg-emerald-600 text-white hover:bg-emerald-700'
        }`}
      >
        {purchasing ? (
          <Loader2 className="w-4 h-4 animate-spin mx-auto" />
        ) : (
          isBundle ? 'Get Complete Prep' : 'Subscribe'
        )}
      </button>
    </div>
  );
}
