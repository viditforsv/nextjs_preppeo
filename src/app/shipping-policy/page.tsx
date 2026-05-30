import type { Metadata } from "next";
import { Breadcrumb } from "@/design-system/components/breadcrumb";

export const metadata: Metadata = {
  title: "Shipping & Delivery Policy | Preppeo",
  description:
    "Preppeo's Shipping & Delivery Policy. Preppeo sells digital products only — mock tests and practice access are delivered instantly to your account, with no physical shipping involved.",
  alternates: {
    canonical: "https://preppeo.com/shipping-policy",
  },
  robots: {
    index: true,
    follow: true,
  },
};

export default function ShippingPolicy() {
  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      {/* Breadcrumb */}
      <div className="bg-white border-b border-gray-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <Breadcrumb
            items={[
              { label: "Home", href: "/" },
              { label: "Shipping & Delivery Policy", href: "/shipping-policy" },
            ]}
          />
        </div>
      </div>

      {/* Shipping & Delivery Policy Content */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="max-w-4xl mx-auto">
          {/* Header */}
          <div className="text-center mb-8 md:mb-12">
            <h1 className="text-5xl font-bold text-foreground mb-4">
              Shipping &amp; Delivery Policy
            </h1>
          </div>

          {/* Content */}
          <div className="bg-white rounded-lg shadow-lg border-0 p-6 md:p-8 lg:p-12">
            <div className="prose prose-sm md:prose-lg max-w-none">
              {/* Introduction */}
              <section className="mb-6 md:mb-8">
                <p className="text-base md:text-lg text-foreground leading-relaxed mb-4 md:mb-6">
                  <span className="font-semibold text-primary">Preppeo</span>,
                  operated by{" "}
                  <span className="font-semibold">
                    Shrivyapar Private Limited
                  </span>
                  , sells <strong>digital products and services only</strong>.
                  There is no physical shipment of goods. This Shipping &amp;
                  Delivery Policy explains how access to our products is
                  delivered after a successful purchase.
                </p>
              </section>

              {/* Digital Delivery */}
              <section className="mb-6 md:mb-8">
                <h2 className="text-xl md:text-2xl font-semibold text-foreground mb-3 md:mb-4">
                  Digital Delivery
                </h2>
                <div className="bg-primary/10 border-l-4 border-primary p-4 md:p-6 rounded-lg mb-4 md:mb-6">
                  <p className="text-base md:text-lg text-foreground leading-relaxed">
                    <strong className="text-primary">Instant access:</strong> All
                    purchases — including mock-test tokens, practice access, and
                    course enrolments — are delivered electronically and
                    activated on your Preppeo account immediately after your
                    payment is confirmed. No physical item is shipped.
                  </p>
                </div>
                <p className="text-base md:text-lg text-foreground leading-relaxed">
                  In rare cases where activation is delayed due to a payment
                  gateway or network issue, access is granted within 24 hours of
                  a successful payment. If you do not receive access within this
                  window, please contact our support team and we will resolve it
                  promptly.
                </p>
              </section>

              {/* Delivery Confirmation */}
              <section className="mb-6 md:mb-8">
                <h2 className="text-xl md:text-2xl font-semibold text-foreground mb-3 md:mb-4">
                  Delivery Confirmation
                </h2>
                <p className="text-base md:text-lg text-foreground leading-relaxed mb-4 md:mb-6">
                  Once your purchase is complete, the product becomes available
                  in your account dashboard, and a confirmation is sent to the
                  email address registered with your account. Please ensure your
                  email address is correct at checkout so you receive your
                  confirmation and access details.
                </p>
              </section>

              {/* Shipping Charges */}
              <section className="mb-6 md:mb-8">
                <h2 className="text-xl md:text-2xl font-semibold text-foreground mb-3 md:mb-4">
                  Shipping Charges
                </h2>
                <p className="text-base md:text-lg text-foreground leading-relaxed mb-4 md:mb-6">
                  As all products are digital and delivered online, there are{" "}
                  <strong>no shipping or delivery charges</strong>. The price
                  shown at checkout is the final price for the product or
                  service.
                </p>
              </section>

              {/* Contact Information */}
              <section className="mb-6 md:mb-8">
                <h2 className="text-xl md:text-2xl font-semibold text-foreground mb-3 md:mb-4">
                  Contact Information
                </h2>
                <p className="text-base md:text-lg text-foreground leading-relaxed mb-4 md:mb-6">
                  For any questions regarding delivery or access to your
                  purchase, please contact us at{" "}
                  <a
                    href="mailto:contact@preppeo.com"
                    className="text-primary hover:text-primary/80 underline font-semibold"
                  >
                    contact@preppeo.com
                  </a>{" "}
                  or{" "}
                  <a
                    href="tel:+918130711689"
                    className="text-primary hover:text-primary/80 underline font-semibold"
                  >
                    +91-8130711689
                  </a>
                  .
                </p>
              </section>

              {/* Important Notes */}
              <section className="mb-6 md:mb-8">
                <div className="bg-primary/10 border-l-4 border-primary p-4 md:p-6 rounded-lg">
                  <h3 className="text-base md:text-lg font-semibold text-foreground mb-3">
                    Important Information
                  </h3>
                  <ul className="text-foreground space-y-2">
                    <li>• Preppeo sells digital products only — nothing is physically shipped</li>
                    <li>• Access is activated instantly after a confirmed payment</li>
                    <li>• Any delayed activation is resolved within 24 hours</li>
                    <li>• There are no shipping or delivery charges</li>
                  </ul>
                </div>
              </section>
            </div>
          </div>

          {/* CTA Section */}
          <div className="text-center mt-8 md:mt-12">
            <div className="bg-gradient-to-br from-[#1a365d] to-[#2a4a7f] rounded-lg p-6 md:p-8 shadow-xl">
              <h3 className="text-xl md:text-2xl font-bold text-white mb-3 md:mb-4">
                Didn&apos;t Receive Your Access?
              </h3>
              <p className="text-white/90 mb-4 md:mb-6 text-sm md:text-base">
                Our support team is here to help if your purchase hasn&apos;t
                activated on your account.
              </p>
              <div className="flex flex-col sm:flex-row gap-3 md:gap-4 justify-center">
                <a
                  href="/contact"
                  className="inline-flex items-center bg-white text-primary hover:bg-gray-100 font-semibold py-3 px-6 rounded-lg transition-colors duration-200 shadow-lg"
                >
                  Contact Support
                </a>
                <a
                  href="mailto:contact@preppeo.com"
                  className="inline-flex items-center bg-white/20 text-white hover:bg-white/30 font-semibold py-3 px-6 rounded-lg transition-colors duration-200"
                >
                  Email Directly
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
