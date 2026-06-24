"use client";

import { AdminOnly } from "@/design-system/components/form-components/RoleGuard";
import { Badge } from "@/design-system/components/ui/badge";
import { Breadcrumb } from "@/design-system/components/breadcrumb";
import UtmBuilderClient from "./UtmBuilderClient";

export default function UtmBuilderPage() {
  return (
    <AdminOnly>
      <div className="min-h-screen bg-background">
        <div className="container mx-auto px-4 py-8 max-w-3xl">
          <div className="mb-6">
            <Breadcrumb
              items={[
                { label: "Home", href: "/" },
                { label: "Admin", href: "/admin/site-administration" },
                { label: "UTM Link Builder", isActive: true },
              ]}
            />
          </div>

          <div className="mb-8 flex items-start justify-between gap-4">
            <div>
              <h1 className="text-3xl font-bold text-foreground">📈 UTM Link Builder</h1>
              <p className="text-muted-foreground mt-2">
                Tags promo links so the PostHog dashboard can tell where a visitor came
                from. Works for <code>preppeo.com</code> and <code>shrividhya.in</code>{" "}
                links.
              </p>
            </div>
            <Badge variant="secondary" className="text-sm shrink-0">
              Admin Tool
            </Badge>
          </div>

          <UtmBuilderClient />
        </div>
      </div>
    </AdminOnly>
  );
}
