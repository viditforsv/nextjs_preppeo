'use client'
import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from '@/design-system/components/ui/button'
import { Input } from '@/design-system/components/ui/input'
import { Label } from '@/design-system/components/ui/label'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/design-system/components/ui/card'
import { Lock, Eye, EyeOff, CheckCircle, AlertCircle, Loader2 } from 'lucide-react'
import { useAuth } from '@/contexts/AuthContext'
import { createClient } from '@/lib/supabase/client'

type SessionStatus = 'verifying' | 'valid' | 'invalid'

export default function ResetPasswordPage() {
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [showPassword, setShowPassword] = useState(false)
  const [showConfirmPassword, setShowConfirmPassword] = useState(false)
  const [isLoading, setIsLoading] = useState(false)
  const [message, setMessage] = useState('')
  const [error, setError] = useState('')
  const [sessionStatus, setSessionStatus] = useState<SessionStatus>('verifying')

  const { updatePassword, user, loading } = useAuth()
  const router = useRouter()

  useEffect(() => {
    if (user) {
      setSessionStatus('valid')
      return
    }

    if (typeof window === 'undefined') return

    const url = new URL(window.location.href)
    const tokenHash = url.searchParams.get('token_hash')
    const type = url.searchParams.get('type')

    // Preferred recovery path: token_hash → verifyOtp. This is stateless
    // (no PKCE code_verifier), so it works when the email is opened on a
    // different device/browser than where the reset was requested, and it's
    // a POST so email-scanner prefetch (GET) can't burn the one-time token.
    if (tokenHash && type === 'recovery') {
      const supabase = createClient()
      supabase.auth
        .verifyOtp({ type: 'recovery', token_hash: tokenHash })
        .then(({ error }) => {
          setSessionStatus(error ? 'invalid' : 'valid')
          // Strip the token from the address bar either way.
          window.history.replaceState({}, '', '/auth/reset-password')
        })
      return
    }

    // Wait for AuthProvider to bootstrap before judging the fallback paths.
    if (loading) return

    // Fallback: legacy PKCE ?code= or implicit #access_token — detectSessionInUrl
    // exchanges these asynchronously, so give it a few seconds before failing.
    const hasLegacyParam =
      url.searchParams.has('code') ||
      url.hash.includes('access_token') ||
      url.hash.includes('type=recovery')

    if (!hasLegacyParam) {
      setSessionStatus('invalid')
      return
    }

    const timer = setTimeout(() => {
      setSessionStatus((prev) => (prev === 'valid' ? prev : 'invalid'))
    }, 6000)
    return () => clearTimeout(timer)
  }, [user, loading])

  const handlePasswordUpdate = async (e: React.FormEvent) => {
    e.preventDefault()
    setIsLoading(true)
    setMessage('')
    setError('')

    if (password !== confirmPassword) {
      setError('Passwords do not match!')
      setIsLoading(false)
      return
    }

    if (password.length < 6) {
      setError('Password must be at least 6 characters long!')
      setIsLoading(false)
      return
    }

    try {
      await updatePassword(password)
      setMessage('Password updated successfully! Redirecting to login...')
      
      // Redirect to login after 2 seconds
      setTimeout(() => {
        router.push('/auth')
      }, 2000)
    } catch (error) {
      console.error('Password update error:', error)
      setError(error instanceof Error ? error.message : 'Failed to update password')
    } finally {
      setIsLoading(false)
    }
  }

  if (sessionStatus === 'verifying') {
    return (
      <div className="min-h-screen bg-gradient-to-br from-[#1a365d]/5 to-[#1a365d]/10 flex items-center justify-center p-4">
        <Card className="w-full max-w-md border-[#1a365d]/10">
          <CardHeader className="text-center">
            <Loader2 className="w-12 h-12 text-[#1a365d] mx-auto mb-4 animate-spin" />
            <CardTitle className="text-xl text-[#1e293b]">Verifying reset link…</CardTitle>
            <CardDescription>
              Hang tight while we confirm your password reset link.
            </CardDescription>
          </CardHeader>
        </Card>
      </div>
    )
  }

  if (sessionStatus === 'invalid') {
    return (
      <div className="min-h-screen bg-gradient-to-br from-[#1a365d]/5 to-[#1a365d]/10 flex items-center justify-center p-4">
        <Card className="w-full max-w-md border-[#1a365d]/10">
          <CardHeader className="text-center">
            <AlertCircle className="w-12 h-12 text-red-500 mx-auto mb-4" />
            <CardTitle className="text-xl text-[#1e293b]">Invalid Reset Link</CardTitle>
            <CardDescription>
              This password reset link is invalid or has expired.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-2">
            <Button
              onClick={() => router.push('/auth/forgot-password')}
              className="w-full bg-[#1a365d] hover:bg-[#1a365d] text-white"
            >
              Request a new link
            </Button>
            <Button
              variant="outline"
              onClick={() => router.push('/auth')}
              className="w-full text-[#1a365d]"
            >
              Go to Login
            </Button>
          </CardContent>
        </Card>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-[#1a365d]/5 to-[#1a365d]/10 flex items-center justify-center p-4">
      <Card className="w-full max-w-md border-[#1a365d]/10">
        <CardHeader className="text-center">
          <Lock className="w-12 h-12 text-[#1a365d] mx-auto mb-4" />
          <CardTitle className="text-xl text-[#1e293b]">Reset Password</CardTitle>
          <CardDescription>
            Enter your new password below.
          </CardDescription>
        </CardHeader>
        <CardContent>
          {message && (
            <div className="mb-4 p-3 border border-green-200 bg-green-50 rounded-md flex items-center">
              <CheckCircle className="h-4 w-4 text-green-600 mr-2" />
              <span className="text-green-800 text-sm">{message}</span>
            </div>
          )}
          
          {error && (
            <div className="mb-4 p-3 border border-red-200 bg-red-50 rounded-md flex items-center">
              <AlertCircle className="h-4 w-4 text-red-600 mr-2" />
              <span className="text-red-800 text-sm">{error}</span>
            </div>
          )}

          <form onSubmit={handlePasswordUpdate} className="space-y-4">
            <div>
              <Label htmlFor="password" className="text-[#1e293b]">New Password</Label>
              <div className="relative">
                <Input
                  id="password"
                  type={showPassword ? "text" : "password"}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="Enter new password"
                  required
                  className="border-[#1a365d]/10 focus:border-[#1a365d] focus:ring-[#1a365d] pr-10"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500 hover:text-gray-700"
                >
                  {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </button>
              </div>
            </div>
            
            <div>
              <Label htmlFor="confirmPassword" className="text-[#1e293b]">Confirm Password</Label>
              <div className="relative">
                <Input
                  id="confirmPassword"
                  type={showConfirmPassword ? "text" : "password"}
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  placeholder="Confirm new password"
                  required
                  className="border-[#1a365d]/10 focus:border-[#1a365d] focus:ring-[#1a365d] pr-10"
                />
                <button
                  type="button"
                  onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                  className="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500 hover:text-gray-700"
                >
                  {showConfirmPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </button>
              </div>
            </div>
            
            <Button
              type="submit"
              disabled={isLoading}
              className="w-full bg-[#1a365d] hover:bg-[#1a365d] text-white disabled:opacity-50"
            >
              {isLoading ? 'Updating Password...' : 'Update Password'}
            </Button>
          </form>
        </CardContent>
      </Card>
    </div>
  )
}
