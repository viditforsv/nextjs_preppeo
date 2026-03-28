import type { MetadataRoute } from 'next';

export default function robots(): MetadataRoute.Robots {
  const baseUrl = process.env.NEXT_PUBLIC_APP_URL || 'https://preppeo.com';

  return {
    rules: [
      {
        userAgent: '*',
        allow: [
          '/',
          '/sat-free',
          '/sat-guide',
          '/sat-test',
          '/mocks',
          '/services/sat',
          '/for-institutes',
          '/contact',
          '/faq',
          '/terms-of-use',
          '/privacy-policy',
          '/refund-policy',
          '/cookies',
          '/careers',
        ],
        disallow: [
          '/admin/',
          '/auth/',
          '/question-bank/',
          '/cart',
          '/profile',
          '/student/',
          '/teacher/',
          '/partner/',
          '/referral',
          '/courses/',
          '/learn/',
          '/gre-test/',
          '/gre-study',
          '/ashoka-test',
          '/cbse10-maths',
          '/cbse10-science',
          '/ibdp-aa-hl',
          '/ibdp-aa-sl',
          '/ibdp-ai-hl',
          '/ibdp-ai-sl',
          '/services/gre',
          '/services/gmat',
          '/services/admissions',
          '/home-v2',
          '/tools',
          '/resources',
          '/onboarding',
        ],
      },
    ],
    sitemap: `${baseUrl}/sitemap.xml`,
  };
}
