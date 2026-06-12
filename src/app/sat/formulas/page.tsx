import type { Metadata } from "next";
import { FormulasContent } from "./FormulasContent";

const baseUrl = process.env.NEXT_PUBLIC_APP_URL || "https://preppeo.com";
const url = `${baseUrl}/sat/formulas`;

const title = "SAT Math Formulas — The Complete Cheat Sheet for the Digital SAT";
const description =
  "Every math formula you need for the Digital SAT in one place — the official Bluebook reference sheet plus the algebra, advanced math, problem-solving & data, geometry, and trig formulas the test expects you to know but never gives you.";

export const metadata: Metadata = {
  title: `${title} | Preppeo`,
  description,
  alternates: { canonical: url },
  openGraph: {
    title: `${title} | Preppeo`,
    description,
    url,
    type: "website",
  },
};

export default function FormulasHubPage() {
  const breadcrumbJsonLd = {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: [
      { "@type": "ListItem", position: 1, name: "Home", item: baseUrl },
      {
        "@type": "ListItem",
        position: 2,
        name: "SAT Math Formulas",
        item: url,
      },
    ],
  };

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(breadcrumbJsonLd) }}
      />
      <FormulasContent />
    </div>
  );
}
