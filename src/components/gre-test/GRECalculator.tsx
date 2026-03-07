'use client';

import { useState, useCallback } from 'react';
import { X, GripVertical } from 'lucide-react';

interface Props {
  onClose: () => void;
}

export default function GRECalculator({ onClose }: Props) {
  const [display, setDisplay] = useState('0');
  const [memory, setMemory] = useState<number | null>(null);
  const [operator, setOperator] = useState<string | null>(null);
  const [waitingForOperand, setWaitingForOperand] = useState(false);

  const inputDigit = useCallback(
    (digit: string) => {
      if (waitingForOperand) {
        setDisplay(digit);
        setWaitingForOperand(false);
      } else {
        setDisplay(display === '0' ? digit : display + digit);
      }
    },
    [display, waitingForOperand]
  );

  const inputDot = useCallback(() => {
    if (waitingForOperand) {
      setDisplay('0.');
      setWaitingForOperand(false);
      return;
    }
    if (!display.includes('.')) {
      setDisplay(display + '.');
    }
  }, [display, waitingForOperand]);

  const clearAll = () => {
    setDisplay('0');
    setMemory(null);
    setOperator(null);
    setWaitingForOperand(false);
  };

  const toggleSign = () => {
    const val = parseFloat(display);
    setDisplay(String(-val));
  };

  const performOperation = useCallback(
    (nextOp: string) => {
      const inputValue = parseFloat(display);
      if (memory === null) {
        setMemory(inputValue);
      } else if (operator) {
        let result = memory;
        switch (operator) {
          case '+': result = memory + inputValue; break;
          case '-': result = memory - inputValue; break;
          case '×': result = memory * inputValue; break;
          case '÷': result = inputValue !== 0 ? memory / inputValue : NaN; break;
        }
        setDisplay(isNaN(result) ? 'Error' : String(parseFloat(result.toFixed(10))));
        setMemory(result);
      }
      setOperator(nextOp === '=' ? null : nextOp);
      setWaitingForOperand(true);
    },
    [display, memory, operator]
  );

  const sqrt = () => {
    const val = parseFloat(display);
    setDisplay(val >= 0 ? String(parseFloat(Math.sqrt(val).toFixed(10))) : 'Error');
  };

  const buttons = [
    ['MC', 'MR', 'M+', 'M-'],
    ['C', '±', '√', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['0', '.', '', '='],
  ];

  const handleButton = (btn: string) => {
    if (btn === '') return;
    if ('0123456789'.includes(btn)) return inputDigit(btn);
    if (btn === '.') return inputDot();
    if (btn === 'C') return clearAll();
    if (btn === '±') return toggleSign();
    if (btn === '√') return sqrt();
    if (['+', '-', '×', '÷', '='].includes(btn)) return performOperation(btn);
    if (btn === 'MC') { setMemory(null); return; }
    if (btn === 'MR' && memory !== null) { setDisplay(String(memory)); return; }
    if (btn === 'M+') { setMemory((memory ?? 0) + parseFloat(display)); return; }
    if (btn === 'M-') { setMemory((memory ?? 0) - parseFloat(display)); return; }
  };

  return (
    <div className="fixed bottom-4 right-4 z-50 w-72 bg-white border-2 border-gray-300 rounded-xl shadow-2xl select-none">
      {/* Title bar */}
      <div className="flex items-center justify-between bg-[#1a365d] text-white px-3 py-2 rounded-t-xl cursor-move">
        <div className="flex items-center gap-1">
          <GripVertical className="w-4 h-4 opacity-60" />
          <span className="text-sm font-medium">Calculator</span>
        </div>
        <button
          onClick={onClose}
          className="w-6 h-6 rounded hover:bg-white/20 flex items-center justify-center"
        >
          <X className="w-4 h-4" />
        </button>
      </div>

      {/* Display */}
      <div className="px-3 pt-2 pb-1">
        <div className="bg-gray-100 border border-gray-200 rounded-lg p-3 text-right font-mono text-xl min-h-11 flex items-center justify-end overflow-hidden">
          <span className="truncate">{display}</span>
        </div>
        {memory !== null && (
          <p className="text-[10px] text-gray-400 text-right mt-0.5">M = {memory}</p>
        )}
      </div>

      {/* Buttons */}
      <div className="px-3 pb-3 pt-1">
        {buttons.map((row, ri) => (
          <div key={ri} className="grid grid-cols-4 gap-1.5 mb-1.5">
            {row.map((btn, ci) => {
              if (btn === '') return <div key={ci} />;
              const isOp = ['+', '-', '×', '÷', '='].includes(btn);
              const isMem = ['MC', 'MR', 'M+', 'M-'].includes(btn);
              const isSpecial = ['C', '±', '√'].includes(btn);

              return (
                <button
                  key={ci}
                  onClick={() => handleButton(btn)}
                  className={`py-2.5 rounded-lg text-sm font-semibold transition-colors ${
                    btn === '='
                      ? 'bg-[#1a365d] text-white hover:bg-[#2a4a7f]'
                      : isOp
                      ? 'bg-gray-200 text-gray-800 hover:bg-gray-300'
                      : isMem
                      ? 'bg-gray-100 text-gray-500 hover:bg-gray-200 text-xs'
                      : isSpecial
                      ? 'bg-gray-200 text-gray-700 hover:bg-gray-300'
                      : 'bg-gray-50 text-gray-800 hover:bg-gray-100 border border-gray-200'
                  }`}
                >
                  {btn}
                </button>
              );
            })}
          </div>
        ))}
      </div>
    </div>
  );
}
