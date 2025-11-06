import type { Metadata } from "next";
import { Nunito_Sans, Merriweather_Sans } from "next/font/google";
import "./globals.css";
import { AuthProvider } from "@/contexts/AuthContext";
import { CartProvider } from "@/contexts/CartContext";
import { Header } from "@/app/components-demo/ui/header";
import { Footer } from "@/app/components-demo/ui/footer";

// Force dynamic rendering to prevent static generation issues
export const dynamic = "force-dynamic";

// Nunito Sans for headers and subheaders
const nunitoSans = Nunito_Sans({
  subsets: ["latin"],
  weight: ["400", "500", "600", "700", "800"],
  variable: "--font-nunito-sans",
  display: "swap",
  fallback: [
    "system-ui",
    "-apple-system",
    "BlinkMacSystemFont",
    "Segoe UI",
    "sans-serif",
  ],
});

// Merriweather Sans for body text
const merriweatherSans = Merriweather_Sans({
  subsets: ["latin"],
  weight: ["300", "400", "500", "600", "700"],
  variable: "--font-merriweather-sans",
  display: "swap",
  fallback: [
    "system-ui",
    "-apple-system",
    "BlinkMacSystemFont",
    "Segoe UI",
    "sans-serif",
  ],
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
        className={`${merriweatherSans.className} ${nunitoSans.variable} ${merriweatherSans.variable}`}
        suppressHydrationWarning={true}
      >
        <AuthProvider>
          <CartProvider>
            <div className="min-h-screen bg-background flex flex-col">
              <Header />
              <main className="flex-1">{children}</main>
              <Footer />
            </div>
          </CartProvider>
        </AuthProvider>
      </body>
    </html>
  );
}
