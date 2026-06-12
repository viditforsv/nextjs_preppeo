"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import { Button } from "./ui/button";
import {
  ChevronDown,
  User,
  LogOut,
  BookOpen,
  FileText,
  HelpCircle,
  Mail,
  Gift,
  ExternalLink,
  Ticket,
} from "lucide-react";
import Image from "next/image";
import { useAuth } from "@/contexts/AuthContext";

export function Header() {
  const [isUserDropdownOpen, setIsUserDropdownOpen] = useState(false);
  const [openNavDropdown, setOpenNavDropdown] = useState<string | null>(null);
  const [isMounted, setIsMounted] = useState(false);
  // Use auth context directly
  const authContext = useAuth();
  const user = authContext?.user;
  const profile = authContext?.profile;
  const signOut = authContext?.signOut;

  // Debug logging for signOut function availability
  useEffect(() => {
    if (isMounted && process.env.NODE_ENV === "development") {
      console.log("Header - signOut function available:", !!signOut);
      console.log("Header - authContext available:", !!authContext);
    }
  }, [isMounted, signOut, authContext]);

  // Debug logging - only log when values actually change
  useEffect(() => {
    if (isMounted && process.env.NODE_ENV === "development") {
      console.log("Header - Auth state:", {
        user: user?.email,
        profile: profile?.role,
        loading: authContext?.loading,
        userExists: !!user,
      });
    }
  }, [isMounted, user?.email, profile?.role, authContext?.loading, user]);

  useEffect(() => {
    setIsMounted(true);
  }, []);

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      const target = event.target as Element;
      if (isUserDropdownOpen && !target.closest(".user-dropdown")) {
        setIsUserDropdownOpen(false);
      }
      if (openNavDropdown && !target.closest(".nav-dropdown")) {
        setOpenNavDropdown(null);
      }
    };

    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, [isUserDropdownOpen, openNavDropdown]);

  // The 5 services shown in the "Services" nav dropdown
  const services = [
    { name: "Mocks", href: "/mocks" },
    { name: "Practice", href: "/sat-test?mode=practice" },
    { name: "Self-Paced Course", href: "/sat/learn" },
    { name: "Book 1-on-1 Sessions", href: "/pricing" },
    { name: "College Admissions Consultancy", href: "/services/admissions" },
  ];

  // Items shown in the "SAT Resources" nav dropdown
  const satResources = [
    { name: "Math Formulas", href: "/sat/formulas" },
    { name: "Guide", href: "/sat-guide" },
    { name: "Desmos Shortcuts", href: "/sat/desmos" },
  ];

  // Get navigation based on user role
  const getNavigation = () => {
    if (!isMounted) return [];

    if (profile?.role === "admin") {
      return [
        { name: "Home", href: "/", hasDropdown: false },
        { name: "Services", href: "#", hasDropdown: true, dropdownItems: services },
        {
          name: "SAT Resources",
          href: "#",
          hasDropdown: true,
          dropdownItems: satResources,
        },
        {
          name: "Site Administration",
          href: "/admin/site-administration",
          hasDropdown: false,
        },
      ];
    } else if (user) {
      return [
        { name: "Home", href: "/", hasDropdown: false },
        { name: "Dashboard", href: "/student", hasDropdown: false },
        { name: "Progress Report", href: "/student/progress", hasDropdown: false },
        { name: "Services", href: "#", hasDropdown: true, dropdownItems: services },
        { name: "Pricing", href: "/pricing", hasDropdown: false },
        {
          name: "SAT Resources",
          href: "#",
          hasDropdown: true,
          dropdownItems: satResources,
        },
      ];
    } else {
      return [
        { name: "Home", href: "/", hasDropdown: false },
        { name: "Services", href: "#", hasDropdown: true, dropdownItems: services },
        {
          name: "SAT Resources",
          href: "#",
          hasDropdown: true,
          dropdownItems: satResources,
        },
        { name: "For Institutes", href: "/for-institutes", hasDropdown: false },
        { name: "Pricing", href: "/pricing", hasDropdown: false },
        { name: "Contact", href: "/contact", hasDropdown: false },
      ];
    }
  };

  const navigation = getNavigation();

  return (
    <header className="bg-white border-b border-gray-200 sticky top-0 z-50 shadow-sm">
      <div className="px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          {/* Logo */}
          <Link
            href="/"
            className="flex items-center space-x-3 hover:opacity-80 transition-opacity"
          >
            <div className="relative w-10 h-10 shrink-0 rounded-lg overflow-hidden">
              <Image
                src="/images/preppeo_logo.png"
                alt="Preppeo LMS Logo"
                fill
                className="object-contain"
                sizes="40px"
              />
            </div>
            <div>
              <h1 className="text-xl font-bold text-foreground">Preppeo</h1>
            </div>
          </Link>

          {/* Main Navigation */}
          <nav className="hidden lg:flex items-center space-x-6">
            {navigation.map((item) =>
              item.hasDropdown ? (
                <div key={item.name} className="relative nav-dropdown">
                  <button
                    onClick={() =>
                      setOpenNavDropdown(
                        openNavDropdown === item.name ? null : item.name
                      )
                    }
                    className="flex items-center px-3 py-2 text-sm font-medium transition-colors text-foreground hover:text-primary"
                  >
                    {item.name}
                    <ChevronDown
                      className={`w-4 h-4 ml-1 transition-transform ${
                        openNavDropdown === item.name ? "rotate-180" : ""
                      }`}
                    />
                  </button>

                  {openNavDropdown === item.name && (
                    <div className="absolute left-0 mt-2 w-64 bg-white rounded-lg shadow-xl border border-gray-200 z-50">
                      <div className="py-2">
                        {item.dropdownItems?.map((sub) => (
                          <Link
                            key={sub.name}
                            href={sub.href}
                            className="block px-4 py-2 text-sm text-foreground hover:bg-primary/10 transition-colors"
                            onClick={() => setOpenNavDropdown(null)}
                          >
                            {sub.name}
                          </Link>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
              ) : (
                <Link
                  key={item.name}
                  href={item.href}
                  className="flex items-center px-3 py-2 text-sm font-medium transition-colors text-foreground hover:text-primary"
                >
                  {item.name}
                </Link>
              )
            )}
          </nav>

          {/* Right Side Actions */}
          <div className="flex items-center space-x-4">
            {/* User Actions */}
            {user ? (
              <>
                <div className="relative user-dropdown">
                  <button
                    onClick={() => setIsUserDropdownOpen(!isUserDropdownOpen)}
                    className="flex items-center space-x-2 px-3 py-2 text-sm font-medium text-foreground hover:text-primary transition-colors rounded-sm hover:bg-gray-100"
                  >
                    <div className="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center overflow-hidden">
                      {profile?.avatar_url ? (
                        <img
                          src={profile.avatar_url}
                          alt={profile?.first_name || user.email || "User"}
                          className="w-full h-full object-cover"
                        />
                      ) : (
                        <span className="text-xs font-semibold text-primary">
                          {profile?.first_name && profile?.last_name
                            ? `${profile.first_name[0]}${profile.last_name[0]}`
                            : user.email?.[0].toUpperCase() || "U"}
                        </span>
                      )}
                    </div>
                    <span className="hidden md:block">
                      {profile?.first_name && profile?.last_name
                        ? `${profile.first_name} ${profile.last_name}`
                        : user.email}
                    </span>
                    <ChevronDown
                      className={`w-4 h-4 text-foreground transition-transform ${
                        isUserDropdownOpen ? "rotate-180" : ""
                      }`}
                    />
                  </button>

                  {/* User Dropdown Menu */}
                  {isUserDropdownOpen && (
                    <div className="absolute right-0 mt-2 w-56 bg-white rounded-lg shadow-xl border border-gray-200 z-50">
                      <div className="py-2">
                        <div className="px-4 py-2 border-b border-gray-200">
                          <p className="text-sm font-medium text-foreground">
                            {profile?.first_name && profile?.last_name
                              ? `${profile.first_name} ${profile.last_name}`
                              : user.email}
                          </p>
                          <p className="text-xs text-muted-foreground">
                            {profile?.role === "admin"
                              ? "Administrator"
                              : profile?.role === "content_manager"
                              ? "Content Manager"
                              : "Student"}
                          </p>
                          <p className="text-xs text-muted-foreground">
                            {user.email}
                          </p>
                        </div>

                        <Link
                          href="/sat/learn"
                          className="flex items-center px-4 py-2 text-sm text-foreground hover:bg-primary/10 transition-colors"
                          onClick={() => setIsUserDropdownOpen(false)}
                        >
                          <BookOpen className="w-4 h-4 mr-3 text-primary" />
                          Dashboard
                        </Link>

                        {(profile?.role === "admin" ||
                          profile?.role === "content_manager") && (
                          <Link
                            href="/question-bank"
                            className="flex items-center px-4 py-2 text-sm text-foreground hover:bg-primary/10 transition-colors"
                            onClick={() => setIsUserDropdownOpen(false)}
                          >
                            <FileText className="w-4 h-4 mr-3 text-primary" />
                            Question Bank
                          </Link>
                        )}

                        <Link
                          href="/profile"
                          className="flex items-center px-4 py-2 text-sm text-foreground hover:bg-primary/10 transition-colors"
                          onClick={() => setIsUserDropdownOpen(false)}
                        >
                          <User className="w-4 h-4 mr-3 text-primary" />
                          Profile
                        </Link>

                        <Link
                          href="/profile/tokens"
                          className="flex items-center px-4 py-2 text-sm text-foreground hover:bg-primary/10 transition-colors"
                          onClick={() => setIsUserDropdownOpen(false)}
                        >
                          <Ticket className="w-4 h-4 mr-3 text-primary" />
                          My Tokens
                        </Link>

                        <Link
                          href="/referral"
                          className="flex items-center px-4 py-2 text-sm text-foreground hover:bg-primary/10 transition-colors"
                          onClick={() => setIsUserDropdownOpen(false)}
                        >
                          <Gift className="w-4 h-4 mr-3 text-emerald-600" />
                          Refer &amp; Earn
                        </Link>

                        <a
                          href="https://help.preppeo.com"
                          target="_blank"
                          rel="noopener noreferrer"
                          className="flex items-center px-4 py-2 text-sm text-foreground hover:bg-primary/10 transition-colors"
                          onClick={() => setIsUserDropdownOpen(false)}
                        >
                          <ExternalLink className="w-4 h-4 mr-3 text-primary" />
                          Help Center
                        </a>

                        <Link
                          href="/faq"
                          className="flex items-center px-4 py-2 text-sm text-foreground hover:bg-primary/10 transition-colors"
                          onClick={() => setIsUserDropdownOpen(false)}
                        >
                          <HelpCircle className="w-4 h-4 mr-3 text-primary" />
                          FAQ
                        </Link>

                        <Link
                          href="/contact"
                          className="flex items-center px-4 py-2 text-sm text-foreground hover:bg-primary/10 transition-colors"
                          onClick={() => setIsUserDropdownOpen(false)}
                        >
                          <Mail className="w-4 h-4 mr-3 text-primary" />
                          Contact
                        </Link>

                        <div className="border-t border-gray-200 mt-2 pt-2">
                          <button
                            onClick={async (e) => {
                              e.preventDefault();
                              e.stopPropagation();
                              console.log("Sign out button clicked");
                              console.log(
                                "signOut function available:",
                                !!signOut
                              );

                              if (!signOut) {
                                console.error(
                                  "signOut function is not available!"
                                );
                                return;
                              }

                              try {
                                setIsUserDropdownOpen(false);
                                console.log("Calling signOut function...");
                                await signOut();
                                console.log("Sign out completed successfully");
                              } catch (error) {
                                console.error("Sign out error:", error);
                              }
                            }}
                            className="flex items-center w-full px-4 py-2 text-sm text-foreground hover:bg-red-50 transition-colors"
                          >
                            <LogOut className="w-4 h-4 mr-3 text-red-600" />
                            Sign Out
                          </button>
                        </div>
                      </div>
                    </div>
                  )}
                </div>
              </>
            ) : (
              <div className="flex items-center space-x-4">
                <Link href="/auth">
                  <Button size="sm" variant="outline">
                    Log In
                  </Button>
                </Link>
                <Link href="/auth">
                  <Button size="sm" variant="primary">Sign Up</Button>
                </Link>
              </div>
            )}

            {/* Removed mobile menu - web-only app */}
          </div>
        </div>

        {/* Removed mobile navigation - web-only app */}
      </div>
    </header>
  );
}

