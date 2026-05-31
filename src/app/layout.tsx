import type { Metadata } from "next";
import { Inter, Lato, Lora } from "next/font/google";
import { headers } from "next/headers";
import "@/design-system/globals.css";
import { AuthProvider } from "@/contexts/AuthContext";
import { CartProvider } from "@/contexts/CartContext";
import { Header } from "@/design-system/components/header";
import { Footer } from "@/design-system/components/footer";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { PostHogProvider } from "@/components/analytics/PostHogProvider";
import { CookieConsentBanner } from "@/components/analytics/CookieConsentBanner";
import {
  regionRequiresConsent,
  buildConsentDefaultScript,
} from "@/lib/consent-region";
import { Analytics } from "@vercel/analytics/next";
import { SpeedInsights } from "@vercel/speed-insights/next";
import { GoogleAnalytics } from "@next/third-parties/google";

// Force dynamic rendering to prevent static generation issues
export const dynamic = "force-dynamic";

// Inter font for the entire application
const inter = Inter({
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
  variable: "--font-inter",
  display: "swap",
  fallback: [
    "system-ui",
    "-apple-system",
    "BlinkMacSystemFont",
    "Segoe UI",
    "sans-serif",
  ],
});

// Lora serif font for SAT passage text
const lora = Lora({
  subsets: ["latin"],
  weight: ["400", "500", "600"],
  style: ["normal", "italic"],
  variable: "--font-lora",
  display: "swap",
});

// Lato font for specific components
const lato = Lato({
  subsets: ["latin"],
  weight: ["400", "700"],
  variable: "--font-lato",
  display: "swap",
});

// Get the base URL for Open Graph images
const baseUrl = process.env.NEXT_PUBLIC_APP_URL || "https://preppeo.com";

export const metadata: Metadata = {
  title: "Preppeo — Digital SAT Prep & Full-Length Mock Tests",
  description:
    "Prepare for the Digital SAT with Preppeo. 5 full-length adaptive mock tests, 2,500+ questions, real College Board-style adaptive routing, and instant score reports. Start your free SAT practice test today.",
  icons: {
    icon: "/images/favicon.ico",
    apple: "/images/apple-touch-icon.png",
    other: [
      {
        rel: "icon",
        type: "image/png",
        sizes: "32x32",
        url: "/images/favicon-32x32.png",
      },
      {
        rel: "icon",
        type: "image/png",
        sizes: "16x16",
        url: "/images/favicon-16x16.png",
      },
    ],
  },
  openGraph: {
    title: "Preppeo — Digital SAT Prep & Full-Length Mock Tests",
    description:
      "Prepare for the Digital SAT with Preppeo. 5 full-length adaptive mock tests, 2,500+ questions, real College Board-style adaptive routing, and instant score reports.",
    url: baseUrl,
    siteName: "Preppeo",
    images: [
      {
        url: "/images/preppeo_logo.png",
        width: 1200,
        height: 630,
        alt: "Preppeo — Digital SAT Prep",
      },
    ],
    locale: "en_US",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Preppeo — Digital SAT Prep & Full-Length Mock Tests",
    description:
      "5 full-length adaptive Digital SAT mock tests. Real adaptive routing, 2,500+ questions, and instant score reports.",
    images: ["/images/preppeo_logo.png"],
  },
};

export default async function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  // EEA/UK/Swiss visitors get default-deny consent + the banner; everyone else
  // is unaffected. Region comes from Vercel's geo header (absent in local dev).
  const country = (await headers()).get("x-vercel-ip-country");
  const requiresConsent = regionRequiresConsent(country);

  return (
    <html lang="en">
      <head>
        {/* Google Consent Mode v2 defaults — native inline script so it runs
            during HTML parse, before GA config and PostHog init. */}
        <script
          id="ga-consent-default"
          dangerouslySetInnerHTML={{
            __html: buildConsentDefaultScript(requiresConsent),
          }}
        />
      </head>
      <body
        className={`${inter.variable} ${lato.variable} ${lora.variable} ${inter.className}`}
        suppressHydrationWarning={true}
      >
        <PostHogProvider requiresConsent={requiresConsent}>
          <AuthProvider>
            <CartProvider>
              <div className="min-h-screen bg-background flex flex-col">
                <Header />
                <ErrorBoundary>
                  <main className="flex-1">{children}</main>
                </ErrorBoundary>
                <Footer />
              </div>
            </CartProvider>
          </AuthProvider>
        </PostHogProvider>
        {/* Traffic + Web Vitals (native to Vercel) */}
        <Analytics />
        <SpeedInsights />
        {/* GA4 — only loads when the Measurement ID env var is set */}
        {process.env.NEXT_PUBLIC_GA_ID && (
          <GoogleAnalytics gaId={process.env.NEXT_PUBLIC_GA_ID} />
        )}
        {/* Consent banner — only for EEA/UK/Swiss visitors */}
        {requiresConsent && <CookieConsentBanner />}
      </body>
    </html>
  );
}
