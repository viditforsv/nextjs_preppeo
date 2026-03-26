On the webhook: Razorpay sends webhooks to a public URL. In dev this won't be reachable. Should I
  build it production-ready only (no local testing), or do you want to use something like ngrok for 
  local testing?

  Ans: build for production ready. ngrok setup is very painful. lets not go there. 
                                                                                                    
  On pack capping: Right now packs are configured in a token_packs table. Should I add a validation 
  in the purchase API that rejects if token_count > available_paid_sets, or should it be enforced at
   the admin level when creating packs?                                                             

Answer: add a validation in the purchase API that rejects if token_count > available_paid_sets. Give the reason to student for the cap. 
                                                            
  On profile widget: Should it show all tokens (all exams) or only SAT for now?               
  Answer: Show only for the exam they have purchased the tokens for or for the courses they have enrolled into. 
   
  Which priority do you want me to start with?                                 
  
