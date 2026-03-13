"use client";

import { Button } from "@/design-system/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/design-system/components/ui/card";
import { Badge } from "@/design-system/components/ui/badge";
import { Mail, Phone, Clock, Send, LifeBuoy } from "lucide-react";
import { useState } from "react";

const categories = [
  { value: "account", label: "Account Issue" },
  { value: "payment", label: "Payment Issue" },
  { value: "test", label: "Test Issue" },
  { value: "bug", label: "Bug Report" },
  { value: "other", label: "Other" },
];

export default function SupportPage() {
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    category: "",
    message: "",
  });
  const [status, setStatus] = useState<
    "idle" | "loading" | "success" | "error"
  >("idle");
  const [errorMsg, setErrorMsg] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setStatus("loading");
    setErrorMsg("");

    try {
      const selectedCategory = categories.find(
        (c) => c.value === formData.category
      );
      const res = await fetch("/api/contact", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: formData.name,
          email: formData.email,
          subject: `Support: ${selectedCategory?.label ?? formData.category}`,
          message: formData.message,
        }),
      });

      if (!res.ok) {
        const data = await res.json();
        throw new Error(data.error || "Failed to send request");
      }

      setStatus("success");
      setFormData({ name: "", email: "", category: "", message: "" });
    } catch (err) {
      setStatus("error");
      setErrorMsg(
        err instanceof Error ? err.message : "Something went wrong"
      );
    }
  };

  const handleChange = (
    e: React.ChangeEvent<
      HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement
    >
  ) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  return (
    <div className="min-h-screen bg-[#f5f5f0]">
      <section className="relative py-20 bg-[#f5f5f0] border-b border-gray-200">
        <div className="container mx-auto px-4 text-center">
          <div className="max-w-4xl mx-auto">
            <div className="flex justify-center mb-6">
              <div className="w-16 h-16 bg-gradient-to-br from-[#1a365d] to-[#2a4a7f] rounded-2xl flex items-center justify-center shadow-lg">
                <LifeBuoy className="w-8 h-8 text-white" />
              </div>
            </div>
            <h1 className="text-5xl font-bold text-foreground mb-6">
              Support
            </h1>
            <p className="text-xl text-muted-foreground mb-8 max-w-3xl mx-auto">
              Need help? Submit a support request and our team will get back to
              you as soon as possible.
            </p>
            <div className="flex flex-wrap justify-center gap-4">
              <Badge
                variant="outline"
                className="border-primary text-primary px-4 py-2"
              >
                <Mail className="w-4 h-4 mr-2" />
                contact@preppeo.com
              </Badge>
              <Badge
                variant="outline"
                className="border-primary text-primary px-4 py-2"
              >
                <Phone className="w-4 h-4 mr-2" />
                +91 - 8130711689
              </Badge>
              <Badge
                variant="outline"
                className="border-primary text-primary px-4 py-2"
              >
                <Clock className="w-4 h-4 mr-2" />
                Mon-Fri 9AM-6PM
              </Badge>
            </div>
          </div>
        </div>
      </section>

      <div className="container mx-auto px-4 py-12 max-w-2xl">
        <Card className="p-8 shadow-xl border-0 rounded-xl">
          <CardHeader>
            <CardTitle className="text-2xl text-foreground">
              Submit a Support Request
            </CardTitle>
            <CardDescription className="text-muted-foreground">
              Describe your issue and we&apos;ll respond within 24 hours.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-6">
              <div>
                <label className="block text-sm font-medium text-foreground mb-2">
                  Name *
                </label>
                <input
                  type="text"
                  name="name"
                  value={formData.name}
                  onChange={handleChange}
                  className="w-full px-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary transition-all bg-white"
                  placeholder="Your name"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-foreground mb-2">
                  Email *
                </label>
                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  className="w-full px-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary transition-all bg-white"
                  placeholder="your-email@example.com"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-foreground mb-2">
                  Category *
                </label>
                <select
                  name="category"
                  value={formData.category}
                  onChange={handleChange}
                  className="w-full px-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary transition-all bg-white"
                  required
                >
                  <option value="">Select a category</option>
                  {categories.map((cat) => (
                    <option key={cat.value} value={cat.value}>
                      {cat.label}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-foreground mb-2">
                  Describe your issue *
                </label>
                <textarea
                  name="message"
                  value={formData.message}
                  onChange={handleChange}
                  rows={6}
                  className="w-full px-4 py-3 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-primary transition-all resize-none bg-white"
                  placeholder="Please describe the issue you're facing in detail..."
                  required
                />
              </div>

              {status === "success" && (
                <div className="p-4 bg-green-50 border border-green-200 rounded-lg text-green-800 text-sm">
                  Your support request has been submitted. We&apos;ll get back
                  to you within 24 hours.
                </div>
              )}
              {status === "error" && (
                <div className="p-4 bg-red-50 border border-red-200 rounded-lg text-red-800 text-sm">
                  {errorMsg}
                </div>
              )}

              <Button
                type="submit"
                disabled={status === "loading"}
                className="w-full bg-primary hover:bg-primary/90 text-white py-3 rounded-lg shadow-lg disabled:opacity-50"
              >
                <Send className="w-4 h-4 mr-2" />
                {status === "loading" ? "Submitting..." : "Submit Request"}
              </Button>
            </form>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
