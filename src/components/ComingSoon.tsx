import Link from "next/link";
import { Clock, ArrowLeft } from "lucide-react";

interface ComingSoonProps {
  title: string;
  description?: string;
}

export function ComingSoon({ title, description }: ComingSoonProps) {
  return (
    <div className="min-h-screen bg-[#f5f5f0] flex items-center justify-center px-4 py-16">
      <div className="max-w-xl w-full text-center space-y-7">
        <div className="flex justify-center">
          <div className="w-20 h-20 bg-gradient-to-br from-[#1a365d] to-[#2a4a7f] rounded-2xl flex items-center justify-center shadow-lg">
            <Clock className="w-10 h-10 text-white" />
          </div>
        </div>

        <span className="inline-flex items-center gap-2 rounded-full bg-[#f4b400] px-4 py-1.5 text-sm font-bold uppercase tracking-widest text-[#1a365d] shadow-sm">
          Coming Soon
        </span>

        <h1 className="text-4xl sm:text-5xl font-bold text-[#1a365d] leading-tight">
          {title}
        </h1>

        <p className="text-lg sm:text-xl text-gray-700 leading-relaxed max-w-lg mx-auto">
          {description || "This page is under construction. Check back soon!"}
        </p>

        <div>
          <Link
            href="/"
            className="inline-flex items-center gap-2 rounded-xl bg-[#1a365d] px-6 py-3 text-sm font-semibold text-white hover:bg-[#2a4a7f] transition-colors"
          >
            <ArrowLeft className="w-4 h-4" />
            Back to Home
          </Link>
        </div>
      </div>
    </div>
  );
}
