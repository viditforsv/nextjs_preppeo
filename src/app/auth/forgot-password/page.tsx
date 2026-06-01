'use client'
import { useState, useEffect } from 'react'
import { Button } from '@/design-system/components/ui/button'
import { Input } from '@/design-system/components/ui/input'
import { Label } from '@/design-system/components/ui/label'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/design-system/components/ui/card'
import { Mail, ArrowLeft, CheckCircle, AlertCircle } from 'lucide-react'
import Link from 'next/link'
import { useAuth } from '@/contexts/AuthContext'

// Matches Supabase's per-user email interval so the button can't out-pace the
// server (which would silently 429 and send nothing).
const RESEND_COOLDOWN = 60

export default function ForgotPasswordPage() {
  const [email, setEmail] = useState('')
  const [isLoading, setIsLoading] = useState(false)
  const [message, setMessage] = useState('')
  const [error, setError] = useState('')
  const [cooldown, setCooldown] = useState(0)

  const { resetPassword } = useAuth()

  // Tick the resend cooldown down once per second.
  useEffect(() => {
    if (cooldown <= 0) return
    const id = setTimeout(() => setCooldown((c) => c - 1), 1000)
    return () => clearTimeout(id)
  }, [cooldown])

  const handlePasswordReset = async (e: React.FormEvent) => {
    e.preventDefault()
    if (cooldown > 0) return
    setIsLoading(true)
    setMessage('')
    setError('')

    if (!email) {
      setError('Please enter your email address')
      setIsLoading(false)
      return
    }

    try {
      await resetPassword(email)
      setMessage(
        `If an account exists for ${email}, a reset link is on its way. It can take a minute to arrive — check your spam folder too.`
      )
      setCooldown(RESEND_COOLDOWN)
    } catch (err) {
      const msg = err instanceof Error ? err.message : ''
      // Supabase returns a 429 / "for security purposes..." when reset emails
      // are requested too fast. Treat that as a soft, self-clearing state.
      if (/rate|seconds|too many|exceed|429/i.test(msg)) {
        setError(
          "You've requested a reset link a moment ago. Please wait before trying again — check your inbox and spam in the meantime."
        )
        setCooldown(RESEND_COOLDOWN)
      } else {
        setError(msg || 'Failed to send reset email')
      }
    } finally {
      setIsLoading(false)
    }
  }

  const buttonLabel = isLoading
    ? 'Sending Reset Link...'
    : cooldown > 0
    ? `Resend in ${cooldown}s`
    : message
    ? 'Resend Reset Link'
    : 'Send Reset Link'

  return (
    <div className="min-h-screen bg-gradient-to-br from-[#1a365d]/5 to-[#1a365d]/10 flex items-center justify-center p-4">
      <Card className="w-full max-w-md border-[#1a365d]/10">
        <CardHeader className="text-center">
          <Mail className="w-12 h-12 text-[#1a365d] mx-auto mb-4" />
          <CardTitle className="text-xl text-[#1e293b]">Forgot Password?</CardTitle>
          <CardDescription>
            Enter your email address and we&apos;ll send you a link to reset your password.
          </CardDescription>
        </CardHeader>
        <CardContent>
          {message && (
            <div className="mb-4 p-3 border border-green-200 bg-green-50 rounded-md flex items-start">
              <CheckCircle className="h-4 w-4 text-green-600 mr-2 mt-0.5 flex-shrink-0" />
              <span className="text-green-800 text-sm">{message}</span>
            </div>
          )}

          {error && (
            <div className="mb-4 p-3 border border-red-200 bg-red-50 rounded-md flex items-start">
              <AlertCircle className="h-4 w-4 text-red-600 mr-2 mt-0.5 flex-shrink-0" />
              <span className="text-red-800 text-sm">{error}</span>
            </div>
          )}

          <form onSubmit={handlePasswordReset} className="space-y-4">
            <div>
              <Label htmlFor="email" className="text-[#1e293b]">Email Address</Label>
              <Input
                id="email"
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="Enter your email address"
                required
                className="border-[#1a365d]/10 focus:border-[#1a365d] focus:ring-[#1a365d]"
              />
            </div>

            <Button
              type="submit"
              disabled={isLoading || cooldown > 0}
              className="w-full bg-[#1a365d] hover:bg-[#1a365d] text-white disabled:opacity-50"
            >
              {buttonLabel}
            </Button>

            {message && cooldown > 0 && (
              <p className="text-xs text-center text-gray-500">
                Didn&apos;t get it? You can resend once the timer ends.
              </p>
            )}
          </form>

          <div className="mt-6 text-center">
            <Link
              href="/auth"
              className="inline-flex items-center text-[#1a365d] hover:text-[#1a365d] text-sm"
            >
              <ArrowLeft className="w-4 h-4 mr-1" />
              Back to Login
            </Link>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
