'use client';

import { useCallback, useEffect, useState } from 'react';
import { Maximize, Minimize } from 'lucide-react';

// Some browsers (Safari) still expose only the webkit-prefixed fullscreen API.
interface FullscreenDocument extends Document {
  webkitFullscreenElement?: Element | null;
  webkitExitFullscreen?: () => Promise<void> | void;
}
interface FullscreenElement extends HTMLElement {
  webkitRequestFullscreen?: () => Promise<void> | void;
}

function isTypingTarget(target: EventTarget | null): boolean {
  const el = target as HTMLElement | null;
  if (!el) return false;
  const tag = el.tagName;
  return (
    tag === 'INPUT' ||
    tag === 'TEXTAREA' ||
    tag === 'SELECT' ||
    el.isContentEditable
  );
}

/**
 * "Distraction Free" mode — drives the native browser Fullscreen API for the
 * exam screen (hides browser tabs/URL bar/OS chrome, Bluebook-like).
 *
 * Keyboard: press "F" to enter (or toggle) fullscreen, "Esc" to exit. Stays in
 * sync when the user exits via the browser's own Esc handling.
 */
export default function FullscreenToggle({ className = '' }: { className?: string }) {
  const [isFullscreen, setIsFullscreen] = useState(false);

  const enter = useCallback(async () => {
    const el = document.documentElement as FullscreenElement;
    try {
      await (el.requestFullscreen?.() ?? el.webkitRequestFullscreen?.());
    } catch {
      // Fullscreen can be blocked (e.g. permissions/iframe) — fail silently.
    }
  }, []);

  const exit = useCallback(async () => {
    const doc = document as FullscreenDocument;
    if (!(doc.fullscreenElement || doc.webkitFullscreenElement)) return;
    try {
      await (doc.exitFullscreen?.() ?? doc.webkitExitFullscreen?.());
    } catch {
      // no-op
    }
  }, []);

  const toggle = useCallback(() => {
    const doc = document as FullscreenDocument;
    if (doc.fullscreenElement || doc.webkitFullscreenElement) {
      void exit();
    } else {
      void enter();
    }
  }, [enter, exit]);

  // Keep state in sync with the browser (covers Esc and other exits).
  useEffect(() => {
    const onChange = () => {
      const doc = document as FullscreenDocument;
      setIsFullscreen(!!(doc.fullscreenElement || doc.webkitFullscreenElement));
    };
    document.addEventListener('fullscreenchange', onChange);
    document.addEventListener('webkitfullscreenchange', onChange);
    onChange();
    return () => {
      document.removeEventListener('fullscreenchange', onChange);
      document.removeEventListener('webkitfullscreenchange', onChange);
    };
  }, []);

  // Keyboard shortcuts: "F" toggles, "Esc" exits.
  useEffect(() => {
    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        void exit();
        return;
      }
      // Don't hijack "F" while the student is typing a response.
      if (isTypingTarget(e.target) || e.metaKey || e.ctrlKey || e.altKey) return;
      if (e.key === 'f' || e.key === 'F') {
        e.preventDefault();
        toggle();
      }
    };
    document.addEventListener('keydown', onKeyDown);
    return () => document.removeEventListener('keydown', onKeyDown);
  }, [toggle, exit]);

  return (
    <button
      onClick={toggle}
      title={
        isFullscreen
          ? 'Exit distraction-free mode (Esc)'
          : 'Distraction-free mode (F)'
      }
      aria-label={
        isFullscreen ? 'Exit distraction-free mode' : 'Distraction-free mode'
      }
      className={`flex items-center gap-1.5 text-sm opacity-80 hover:opacity-100 transition-opacity ${className}`}
    >
      {isFullscreen ? (
        <Minimize className="w-4 h-4" />
      ) : (
        <Maximize className="w-4 h-4" />
      )}
      <span className="hidden sm:inline">
        {isFullscreen ? 'Exit' : 'Distraction Free'}
      </span>
    </button>
  );
}
