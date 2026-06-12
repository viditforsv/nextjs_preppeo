"use client";

import { useState } from "react";
import Link from "next/link";
import {
  Mail,
  MessageCircle,
  X,
  Send,
  ChevronLeft,
  Check,
  ChevronRight,
  ShoppingCart,
  CalendarClock,
  GraduationCap,
} from "lucide-react";
import { REGION_LINKS, type Region } from "@/lib/region";

/* ── Palette ──────────────────────────────────────────────────── */
const NAVY = "#1a365d";
const AMBER = "#f4b400";
const WHATSAPP = "#25D366";

type View = "menu" | "email";
type Status = "idle" | "loading" | "success" | "error";

export function FloatingWidget({ region = "in" }: { region?: Region }) {
  const [isOpen, setIsOpen] = useState(false);
  const [view, setView] = useState<View>("menu");

  const [form, setForm] = useState({
    name: "",
    email: "",
    subject: "",
    message: "",
  });
  const [status, setStatus] = useState<Status>("idle");
  const [errorMsg, setErrorMsg] = useState("");

  const links = REGION_LINKS[region];

  const close = () => {
    setIsOpen(false);
    // reset back to the menu the next time it opens
    setTimeout(() => {
      setView("menu");
      setStatus("idle");
    }, 200);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setStatus("loading");
    setErrorMsg("");
    try {
      const res = await fetch("/api/contact", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: form.name,
          email: form.email,
          subject: form.subject || "Website widget enquiry",
          message: form.message,
        }),
      });
      if (!res.ok) {
        const data = await res.json().catch(() => ({}));
        throw new Error(data.error || "Something went wrong. Please try again.");
      }
      setStatus("success");
      setForm({ name: "", email: "", subject: "", message: "" });
    } catch (err) {
      setStatus("error");
      setErrorMsg(
        err instanceof Error ? err.message : "Something went wrong. Please try again."
      );
    }
  };

  const inputClass =
    "w-full px-3 py-2 text-sm border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary transition-all bg-white text-foreground placeholder-gray-400";

  /* ── Geo-differentiated link actions ──────────────────────────── */
  const linkActions = [
    {
      key: "whatsapp",
      href: links.whatsapp,
      external: true,
      icon: <MessageCircle className="h-5 w-5" />,
      iconBg: "#e7f9ee",
      iconColor: WHATSAPP,
      label: "Chat on WhatsApp",
      sub: "Quick replies during IST hours",
    },
    {
      key: "book",
      href: links.book,
      external: false,
      icon: <CalendarClock className="h-5 w-5" />,
      iconBg: "#eef2f7",
      iconColor: NAVY,
      label: "Book a 1-on-1 session",
      sub: region === "in" ? "₹ rate · IST" : "$ rate · your timezone",
    },
    {
      key: "buy",
      href: links.buy,
      external: false,
      icon: <ShoppingCart className="h-5 w-5" />,
      iconBg: "#eef2f7",
      iconColor: NAVY,
      label: "Buy a mock or course",
      sub: region === "in" ? "₹ · UPI + cards" : "$ · international cards",
    },
    {
      key: "admissions",
      href: links.admissions,
      external: false,
      icon: <GraduationCap className="h-5 w-5" />,
      iconBg: "#eef2f7",
      iconColor: NAVY,
      label: "Admissions consulting",
      sub: region === "in" ? "India + study-abroad" : "Study-abroad track",
    },
  ];

  const ActionInner = ({
    icon,
    iconBg,
    iconColor,
    label,
    sub,
  }: {
    icon: React.ReactNode;
    iconBg: string;
    iconColor: string;
    label: string;
    sub: string;
  }) => (
    <>
      <span
        className="flex h-9 w-9 flex-shrink-0 items-center justify-center rounded-lg"
        style={{ background: iconBg, color: iconColor }}
      >
        {icon}
      </span>
      <span className="min-w-0 flex-1">
        <span className="block text-sm font-semibold text-foreground">
          {label}
        </span>
        <span className="block text-xs text-gray-500">{sub}</span>
      </span>
      <ChevronRight className="h-4 w-4 flex-shrink-0 text-gray-300" />
    </>
  );

  const actionClass =
    "flex w-full items-center gap-3 rounded-xl border border-gray-200 p-3 text-left hover:border-gray-300 hover:bg-gray-50 transition-all";

  return (
    <div className="fixed bottom-5 right-5 z-50 flex flex-col items-end">
      {/* ── Panel ──────────────────────────────────────────────── */}
      {isOpen && (
        <div className="mb-3 w-[20rem] max-w-[calc(100vw-2.5rem)] rounded-2xl bg-white shadow-2xl border border-gray-200 overflow-hidden">
          {/* Header */}
          <div
            className="flex items-center justify-between px-4 py-3"
            style={{ background: NAVY }}
          >
            <div className="flex items-center gap-2">
              {view === "email" && status !== "success" && (
                <button
                  onClick={() => setView("menu")}
                  aria-label="Back"
                  className="text-white/70 hover:text-white transition-colors"
                >
                  <ChevronLeft className="w-4 h-4" />
                </button>
              )}
              <p className="text-white font-semibold text-sm">
                {view === "menu" ? "How can we help?" : "Email us"}
              </p>
            </div>
            <button
              onClick={close}
              aria-label="Close"
              className="text-white/70 hover:text-white transition-colors"
            >
              <X className="w-4 h-4" />
            </button>
          </div>

          {/* ── Menu view ──────────────────────────────────────── */}
          {view === "menu" && (
            <div className="max-h-[70vh] overflow-y-auto p-3 space-y-2">
              {linkActions.map((a) =>
                a.external ? (
                  <a
                    key={a.key}
                    href={a.href}
                    target="_blank"
                    rel="noopener noreferrer"
                    onClick={close}
                    className={actionClass}
                  >
                    <ActionInner {...a} />
                  </a>
                ) : (
                  <Link
                    key={a.key}
                    href={a.href}
                    onClick={close}
                    className={actionClass}
                  >
                    <ActionInner {...a} />
                  </Link>
                )
              )}

              {/* Email — opens the in-widget form */}
              <button onClick={() => setView("email")} className={actionClass}>
                <ActionInner
                  icon={<Mail className="h-5 w-5" />}
                  iconBg="#eef2f7"
                  iconColor={NAVY}
                  label="Drop us an email"
                  sub="We'll reply within 24 hours"
                />
              </button>

              {/* Region-aware support note */}
              <p className="px-1 pt-1 text-center text-[11px] text-gray-400">
                {links.supportNote}
              </p>
            </div>
          )}

          {/* ── Email form view ────────────────────────────────── */}
          {view === "email" && (
            <div className="p-4">
              {status === "success" ? (
                <div className="py-6 text-center">
                  <div
                    className="mx-auto mb-3 flex h-12 w-12 items-center justify-center rounded-full"
                    style={{ background: "#dcfce7", color: "#16a34a" }}
                  >
                    <Check className="h-6 w-6" />
                  </div>
                  <p className="font-semibold text-foreground">Message sent!</p>
                  <p className="mt-1 text-sm text-gray-500">
                    We&apos;ve emailed our team and will get back to you shortly.
                  </p>
                  <button
                    onClick={close}
                    className="mt-4 text-sm font-semibold"
                    style={{ color: NAVY }}
                  >
                    Done
                  </button>
                </div>
              ) : (
                <form onSubmit={handleSubmit} className="space-y-3">
                  <input
                    type="text"
                    required
                    placeholder="Your name"
                    value={form.name}
                    onChange={(e) => setForm({ ...form, name: e.target.value })}
                    className={inputClass}
                  />
                  <input
                    type="email"
                    required
                    placeholder="Your email"
                    value={form.email}
                    onChange={(e) => setForm({ ...form, email: e.target.value })}
                    className={inputClass}
                  />
                  <input
                    type="text"
                    placeholder="Subject (optional)"
                    value={form.subject}
                    onChange={(e) =>
                      setForm({ ...form, subject: e.target.value })
                    }
                    className={inputClass}
                  />
                  <textarea
                    required
                    rows={4}
                    placeholder="How can we help you?"
                    value={form.message}
                    onChange={(e) =>
                      setForm({ ...form, message: e.target.value })
                    }
                    className={`${inputClass} resize-none`}
                  />

                  {status === "error" && (
                    <p className="text-xs text-red-600">{errorMsg}</p>
                  )}

                  <button
                    type="submit"
                    disabled={status === "loading"}
                    className="flex w-full items-center justify-center gap-2 rounded-lg py-2.5 text-sm font-bold transition-opacity disabled:opacity-60"
                    style={{ background: AMBER, color: NAVY }}
                  >
                    {status === "loading" ? (
                      "Sending…"
                    ) : (
                      <>
                        Send <Send className="h-4 w-4" />
                      </>
                    )}
                  </button>

                  <p className="text-center text-[11px] text-gray-400">
                    {links.supportNote}
                  </p>
                </form>
              )}
            </div>
          )}
        </div>
      )}

      {/* ── Launcher button ────────────────────────────────────── */}
      <button
        onClick={() => (isOpen ? close() : setIsOpen(true))}
        aria-label={isOpen ? "Close help widget" : "Open help widget"}
        className="flex h-14 w-14 items-center justify-center rounded-full shadow-lg transition-transform hover:scale-105 active:scale-95"
        style={{ background: NAVY }}
      >
        {isOpen ? (
          <X className="h-6 w-6 text-white" />
        ) : (
          <MessageCircle className="h-6 w-6 text-white" />
        )}
      </button>
    </div>
  );
}
