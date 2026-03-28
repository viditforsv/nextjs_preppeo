import type { Metadata } from "next";
import { Inter, Lato, Lora } from "next/font/google";
import "@/design-system/globals.css";
import { AuthProvider } from "@/contexts/AuthContext";
import { CartProvider } from "@/contexts/CartContext";
import { Header } from "@/design-system/components/header";
import { Footer } from "@/design-system/components/footer";
import { ErrorBoundary } from "@/components/ErrorBoundary";

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
  title: "Preppeo LMS - Learning Management System",
  description:
    "A modern learning management system built with Next.js and Supabase",
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
    title: "Preppeo LMS - Learning Management System",
    description:
      "A modern learning management system built with Next.js and Supabase",
    url: baseUrl,
    siteName: "Preppeo LMS",
    images: [
      {
        url: "/images/preppeo_logo.png",
        width: 1200,
        height: 630,
        alt: "Preppeo LMS Logo",
      },
    ],
    locale: "en_US",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Preppeo LMS - Learning Management System",
    description:
      "A modern learning management system built with Next.js and Supabase",
    images: ["/images/preppeo_logo.png"],
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body
        className={`${inter.variable} ${lato.variable} ${lora.variable} ${inter.className}`}
        suppressHydrationWarning={true}
      >
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
      </body>
    </html>
  );
}
