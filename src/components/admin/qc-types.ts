import { ReactNode } from 'react';

export interface FilterOption {
  value: string;
  label: string;
}

export interface FilterDef {
  key: string;
  label: string;
  options: FilterOption[] | 'dynamic';
  /** When options is 'dynamic', provide a function to derive them from the full question list */
  deriveOptions?: (questions: QCQuestion[]) => FilterOption[];
  /** Called when this filter changes – can reset dependant filters */
  onChangeSideEffect?: (value: string, setFilters: (fn: (f: Record<string, string>) => Record<string, string>) => void) => void;
}

export interface MetadataBadgeDef<Q> {
  key: string;
  render: (q: Q) => ReactNode;
}

export interface EditFieldDef<Q> {
  key: keyof Q & string;
  label: string;
  type: 'select' | 'text' | 'number' | 'textarea' | 'json';
  options?: FilterOption[];
  rows?: number;
  colSpan?: 1 | 2 | 3;
  placeholder?: string;
}

export interface QCQuestion {
  id: string;
  type: string;
  difficulty: string;
  prompt: string;
  options?: { id: string; text: string }[];
  correctAnswer: string;
  explanation: string;
  imageUrl?: string;
  aiExplanation?: string;
  aiTheory?: string;
  qcDone?: boolean;
  [key: string]: unknown;
}

export interface QCPageConfig<Q extends QCQuestion = QCQuestion> {
  title: string;
  breadcrumbLabel: string;
  subtitle: string;
  apiBase: string;
  hasImageUpload: boolean;
  hasAIRegenerate: boolean;
  hasPassage: boolean;
  filters: FilterDef[];
  sortFn: (a: Q, b: Q) => number;
  /** Function to match a question to a UUID search (some courses also match bankItemId) */
  matchUuid?: (q: Q, uuid: string) => boolean;
  metadataBadges: MetadataBadgeDef<Q>[];
  editFields: EditFieldDef<Q>[];
  /** Custom renderer for the question body in view mode */
  renderQuestion: (q: Q) => ReactNode;
  /** Custom filter predicate – receives the current filter state */
  filterFn: (q: Q, filters: Record<string, string>) => boolean;
  /** Called when filters are cleared (for UUID jump) – returns reset filter state */
  getResetFilters: () => Record<string, string>;
  /**
   * When true, questions are NOT fetched on page load.
   * An "Apply Filters" button is shown — clicking it triggers a server-side fetch
   * using the params built by buildServerParams. Limit is enforced server-side.
   */
  fetchOnApply?: boolean;
  /** Maps the current filter state to server-side query params for the fetch. */
  buildServerParams?: (filters: Record<string, string>) => Record<string, string>;
  /**
   * URL to fetch summary stats shown in a banner above the filters.
   * Response must be: { pending: { [key: string]: number } }
   * The banner renders each key-value pair as "Key: N".
   */
  statsUrl?: string;
}
