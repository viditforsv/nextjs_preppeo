import Link from "next/link"

const footerLinks: {
  services: { name: string; href?: string; comingSoon?: boolean }[]
  company: { name: string; href: string }[]
  resources: { name: string; href: string }[]
  legal: { name: string; href: string }[]
} = {
  services: [
    { name: "Digital SAT Mocks", href: "/mocks" },
    { name: "Unlimited Practice Mode", href: "/sat-test" },
    { name: "Self-Paced SAT Course", comingSoon: true },
    { name: "Premium 1-on-1 Coaching", href: "/contact" },
  ],
  company: [
    { name: "Contact", href: "/contact" },
    { name: "For Institutes", href: "/for-institutes" },
    { name: "Help Center", href: "https://help.preppeo.com" },
    { name: "FAQ", href: "/faq" },
    { name: "Careers", href: "/careers" },
  ],
  resources: [
    { name: "Question of the Day", href: "/question-of-the-day" },
    { name: "SAT Desmos Shortcuts", href: "/sat/desmos" },
    { name: "Free Score Diagnostic", href: "/sat-free" },
    { name: "SAT Prep Blog", href: "/resources" },
  ],
  legal: [
    { name: "Privacy Policy", href: "/privacy-policy" },
    { name: "Terms of Service", href: "/terms-of-use" },
    { name: "Cancellation & Refund Policy", href: "/refund-policy" },
    { name: "Shipping & Delivery Policy", href: "/shipping-policy" },
    { name: "Cookie Policy", href: "/cookies" },
  ],
}

export function Footer() {
  return (
    <footer className="bg-primary text-white relative overflow-hidden">
        {/* Wavy pattern background */}
        <div className="absolute top-0 left-0 right-0 h-[50px]">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 1000 100"
            preserveAspectRatio="none"
            className="w-full h-full"
          >
            <path
              className="elementor-shape-fill"
              opacity="0.33"
              d="M473,67.3c-203.9,88.3-263.1-34-320.3,0C66,119.1,0,59.7,0,59.7V0h1000v59.7 c0,0-62.1,26.1-94.9,29.3c-32.8,3.3-62.8-12.3-75.8-22.1C806,49.6,745.3,8.7,694.9,4.7S492.4,59,473,67.3z"
              fill="currentColor"
            />
            <path
              className="elementor-shape-fill"
              opacity="0.66"
              d="M734,67.3c-45.5,0-77.2-23.2-129.1-39.1c-28.6-8.7-150.3-10.1-254,39.1 s-91.7-34.4-149.2,0C115.7,118.3,0,39.8,0,39.8V0h1000v36.5c0,0-28.2-18.5-92.1-18.5C810.2,18.1,775.7,67.3,734,67.3z"
              fill="currentColor"
            />
            <path
              className="elementor-shape-fill"
              d="M766.1,28.9c-200-57.5-266,65.5-395.1,19.5C242,1.8,242,5.4,184.8,20.6C128,35.8,132.3,44.9,89.9,52.5C28.6,63.7,0,0,0,0 h1000c0,0-9.9,40.9-83.6,48.1S829.6,47,766.1,28.9z"
              fill="currentColor"
            />
          </svg>
        </div>

        <div className="w-full px-4 py-12 md:py-16 relative z-10">
          <div className="container max-w-7xl mx-auto">
            <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-5">
              {/* Services Column */}
              <div className="space-y-4">
                <h3 className="text-sm font-semibold uppercase tracking-wider">Services</h3>
                <ul className="space-y-2">
                  {footerLinks.services.map((link) => (
                    <li key={link.name}>
                      {link.comingSoon ? (
                        <span className="inline-flex items-center gap-2 text-sm text-white/50">
                          {link.name}
                          <span className="rounded bg-white/10 px-1.5 py-0.5 text-[10px] font-medium uppercase tracking-wide">
                            Coming soon
                          </span>
                        </span>
                      ) : (
                        <Link
                          href={link.href!}
                          className="text-sm text-white/80 hover:text-white transition-colors"
                        >
                          {link.name}
                        </Link>
                      )}
                    </li>
                  ))}
                </ul>
              </div>

              {/* Company Column */}
              <div className="space-y-4">
                <h3 className="text-sm font-semibold uppercase tracking-wider">Company</h3>
                <ul className="space-y-2">
                  {footerLinks.company.map((link) => (
                    <li key={link.href}>
                      {link.href.startsWith("http") ? (
                        <a
                          href={link.href}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-sm text-white/80 hover:text-white transition-colors"
                        >
                          {link.name}
                        </a>
                      ) : (
                        <Link
                          href={link.href}
                          className="text-sm text-white/80 hover:text-white transition-colors"
                        >
                          {link.name}
                        </Link>
                      )}
                    </li>
                  ))}
                </ul>
              </div>

              {/* Resources Column */}
              <div className="space-y-4">
                <h3 className="text-sm font-semibold uppercase tracking-wider">Resources</h3>
                <ul className="space-y-2">
                  {footerLinks.resources.map((link) => (
                    <li key={link.href}>
                      <Link
                        href={link.href}
                        className="text-sm text-white/80 hover:text-white transition-colors"
                      >
                        {link.name}
                      </Link>
                    </li>
                  ))}
                </ul>
              </div>

              {/* About Preppeo - Large Text Block */}
              <div className="space-y-4 lg:col-span-2">
                <h3 className="text-sm font-semibold uppercase tracking-wider">About Preppeo</h3>
                <p className="text-sm text-white/80 leading-relaxed max-w-md">
                  Preppeo is a premium adaptive preparation platform specializing in
                  full-length mock tests and AI-powered practice modules for the Digital
                  SAT. Our engine mirrors official test parameters to deliver hyper-precise
                  score predictions and domain-level metrics that drive real performance
                  breakthroughs.
                </p>
              </div>
            </div>
          </div>

          {/* Bottom Section */}
          <div className="border-t border-white/20 mt-12 pt-8">
            <div className="max-w-7xl mx-auto">
              <div className="flex flex-col md:flex-row items-center justify-center gap-4 text-sm text-white/80">
                <span>© {new Date().getFullYear()} Preppeo. All rights reserved.</span>
                <div className="flex flex-wrap justify-center gap-x-4 gap-y-2">
                  {footerLinks.legal.map((link) => (
                    <Link
                      key={link.href}
                      href={link.href}
                      className="hover:text-white transition-colors"
                    >
                      {link.name}
                    </Link>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>
      </footer>
  )
}
