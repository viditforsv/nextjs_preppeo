'use client';

import { useEffect, useRef, useState } from 'react';
import { X, Maximize2, Minimize2 } from 'lucide-react';

declare global {
  interface Window {
    Desmos: {
      GraphingCalculator: (
        el: HTMLElement,
        options?: Record<string, unknown>
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      ) => any;
    };
  }
}

interface DesmosCalculatorProps {
  onClose: () => void;
}

function loadDesmosScript(): Promise<boolean> {
  if (window.Desmos) return Promise.resolve(true);
  return new Promise((resolve) => {
    const apiKey = process.env.NEXT_PUBLIC_DESMOS_API_KEY || '7ec567acab5644a88d78433aa0351089';
    const script = document.createElement('script');
    script.src = `https://www.desmos.com/api/v1.11/calculator.js?apiKey=${apiKey}`;
    script.onload = () => resolve(true);
    script.onerror = () => resolve(false);
    document.head.appendChild(script);
  });
}

export default function DesmosCalculator({ onClose }: DesmosCalculatorProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const calcRef = useRef<any>(null);
  const [loaded, setLoaded] = useState(false);
  const [expanded, setExpanded] = useState(false);

  useEffect(() => {
    let mounted = true;

    loadDesmosScript().then((ok) => {
      if (!ok || !mounted || !containerRef.current) return;
      calcRef.current = window.Desmos.GraphingCalculator(containerRef.current, {
        keypad: true,
        expressions: true,
        settingsMenu: false,
        zoomButtons: true,
        expressionsTopbar: false,
        border: false,
        restrictedFunctions: true,
        forceEnableGeometryFunctions: true,
        pasteGraphLink: false,
        images: false,
        links: false,
        degreeMode: true,
      });
      setLoaded(true);
    });

    return () => {
      mounted = false;
      if (calcRef.current) {
        calcRef.current.destroy();
        calcRef.current = null;
      }
    };
  }, []);

  const panelWidth = expanded ? 'w-[700px]' : 'w-[420px]';
  const panelHeight = expanded ? 'h-[85vh]' : 'h-[500px]';

  return (
    <div
      className={`fixed bottom-4 right-4 z-50 bg-white rounded-xl shadow-2xl border border-gray-200 flex flex-col overflow-hidden transition-all duration-200 ${panelWidth} ${panelHeight}`}
    >
      {/* Header */}
      <div className="flex items-center justify-between px-4 py-2 bg-gray-50 border-b border-gray-200 shrink-0">
        <span className="text-sm font-semibold text-gray-700">Graphing Calculator</span>
        <div className="flex items-center gap-1">
          <button
            onClick={() => setExpanded(!expanded)}
            className="p-1 text-gray-400 hover:text-gray-600 transition-colors"
            title={expanded ? 'Minimize' : 'Maximize'}
          >
            {expanded ? <Minimize2 className="w-4 h-4" /> : <Maximize2 className="w-4 h-4" />}
          </button>
          <button
            onClick={onClose}
            className="p-1 text-gray-400 hover:text-gray-600 transition-colors"
            title="Close"
          >
            <X className="w-4 h-4" />
          </button>
        </div>
      </div>

      {/* Calculator */}
      <div ref={containerRef} className="flex-1" />

      {!loaded && (
        <div className="absolute inset-0 flex items-center justify-center bg-white/80">
          <div className="text-sm text-gray-500">Loading calculator...</div>
        </div>
      )}
    </div>
  );
}
