import Link from "next/link";
import { ArrowLeft, ArrowRight } from "lucide-react";
import MyTokens from "@/components/tests/MyTokens";

export const metadata = {
  title: "My Tokens — Preppeo",
  robots: { index: false, follow: false },
};

export default function MyTokensPage() {
  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <div className="mx-auto max-w-4xl px-4 py-12">
        <Link
          href="/profile"
          className="mb-4 inline-flex items-center gap-1 text-sm text-gray-500 hover:text-[#1a365d]"
        >
          <ArrowLeft className="h-4 w-4" /> Back to Profile
        </Link>

        <div className="mb-6 flex flex-wrap items-center justify-between gap-3">
          <div>
            <h1 className="text-3xl font-bold text-[#1a365d]">My Tokens</h1>
            <p className="mt-1 text-gray-600">
              Your mock test access codes — copy or redeem them anytime.
            </p>
          </div>
          <Link href="/pricing">
            <span className="inline-flex items-center gap-1.5 rounded-lg bg-[#1a365d] px-4 py-2.5 text-sm font-semibold text-white transition-colors hover:bg-[#2a4a7f]">
              Buy more mocks <ArrowRight className="h-4 w-4" />
            </span>
          </Link>
        </div>

        <div className="rounded-xl border border-gray-200 bg-white p-6">
          <MyTokens />
        </div>
      </div>
    </div>
  );
}
