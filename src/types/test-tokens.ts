export interface ExamType {
  id: string;
  name: string;
  description: string | null;
  icon_url: string | null;
  is_active: boolean;
  total_sets: number;
  test_route: string;
  created_at: string;
}

export interface TestToken {
  id: string;
  code: string;
  exam_type: string;
  set_number: number;
  is_free: boolean;
  owner_id: string | null;
  is_used: boolean;
  used_at: string | null;
  used_by: string | null;
  purchase_id: string | null;
  batch_id: string | null;
  is_active: boolean;
  created_at: string;
}

export interface TokenPack {
  id: string;
  exam_type: string;
  name: string;
  token_count: number;
  price: number;
  is_active: boolean;
  created_at: string;
}

export interface TokenPurchase {
  id: string;
  user_id: string;
  pack_id: string;
  razorpay_order_id: string | null;
  razorpay_payment_id: string | null;
  amount: number;
  currency: string;
  status: 'pending' | 'completed' | 'failed' | 'refunded';
  tokens_generated: number;
  created_at: string;
}

export interface TokenPackWithExam extends TokenPack {
  exam_types: ExamType;
}

export interface TestTokenWithExam extends TestToken {
  exam_types: ExamType;
}
