This plan is designed for an AI agent (like Cursor/Claude) to implement a robust, scalable token and partner ecosystem. It treats tokens as a **ledger-based currency** rather than just a "coupon code."

---

## 🏗️ Phase 1: Database Schema (Supabase / Postgres)

The AI should create these core tables. The logic uses a "Ledger" approach for tokens to ensure 100% financial accuracy.

```sql
-- 1. Profiles (Extends Auth)
CREATE TABLE profiles (
  id UUID REFERENCES auth.users PRIMARY KEY,
  role TEXT DEFAULT 'student', -- 'student', 'partner', 'admin'
  partner_commission_rate NUMERIC DEFAULT 10.0 -- Default %
);

-- 2. Partner Ledger (The "Bank" for Partners)
CREATE TABLE partner_vaults (
  partner_id UUID REFERENCES profiles(id) PRIMARY KEY,
  token_balance INTEGER DEFAULT 0,
  referral_code TEXT UNIQUE, -- e.g., 'PARTNER30'
  discount_offered NUMERIC DEFAULT 15.0 -- % discount for students using this code
);

-- 3. Token Transactions (Audit Trail)
CREATE TABLE token_transactions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  sender_id UUID REFERENCES profiles(id),
  receiver_id UUID REFERENCES profiles(id),
  amount INTEGER NOT NULL,
  transaction_type TEXT, -- 'purchase', 'transfer', 'referral_bonus', 'usage'
  metadata JSONB, -- Store Razorpay Order ID here
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Active Tokens (Summary Table)
CREATE TABLE user_tokens (
  user_id UUID REFERENCES profiles(id) PRIMARY KEY,
  balance INTEGER DEFAULT 0
);

```

---

## Phase 2: Backend Logic (Next.js API Routes)

The AI should implement these three specific flows:

### 1. The "Discount Resolver" API

**Goal:** Calculate the price *before* creating a Razorpay order.

* **Logic:** * Input: `token_quantity`, `referral_code` (optional).
* Check `partner_vaults` for the code.
* Apply the `discount_offered`.
* Return `final_amount` to the frontend.



### 2. Razorpay Order Creation (`/api/payment/create`)

* **Action:** Create a Razorpay Order.
* **Meta-data:** Attach `partner_id` and `student_id` to the Razorpay `notes` object. This ensures you know who to credit if the webhook fires.

### 3. Payment Verification & Token Minting (`/api/payment/verify`)

* **Action:** Validate Razorpay signature.
* **Action (Atomic Transaction):** 1. Update `user_tokens` (Student receives tokens).
2. If a Partner code was used: Update `partner_vaults` (Partner receives commission/tokens).
3. Log entry in `token_transactions`.

---

## Phase 3: Token Transfer Logic

Since you want students to transfer tokens "as they feel right," the AI must build a **secure transfer function**.

* **Logic:**
1. Check `user_tokens` to ensure `balance >= transfer_amount`.
2. Subtract from Sender.
3. Add to Receiver.
4. **Critical:** Use a **Supabase RPC (Database Function)** to ensure these two steps happen simultaneously (Atomic). If one fails, both roll back.



---

## Phase 4: Partner Split (Something Extra)

If you want to automate cash payouts, tell the AI to use **Razorpay Route**.

* **Setup:**
* When a Partner signs up, create a "Linked Account" in Razorpay.
* In the `createOrder` API, add a `transfers` array:
```json
"transfers": [
  {
    "account": "acc_PARTNER_ID",
    "amount": 1000, 
    "currency": "INR"
  }
]

```


* Razorpay will automatically split the money at the moment of payment.



---

## 🤖 Prompt for your AI Agent (Cursor)

Copy and paste this into Cursor:

> "Build a token-based testing platform infrastructure using Next.js, Supabase, and Razorpay.
> 1. Create a database schema with `profiles`, `partner_vaults`, `token_transactions`, and `user_tokens`.
> 2. Implement a Next.js API route to create a Razorpay order that applies a custom discount if a partner referral code is provided.
> 3. Create a verification webhook that updates the user's token balance in Supabase and logs the transaction.
> 4. Create a Supabase RPC function for secure peer-to-peer token transfers between users, ensuring atomic updates to prevent double-spending."
> 
> 

**Would you like me to refine the transfer logic code for the AI to follow?**