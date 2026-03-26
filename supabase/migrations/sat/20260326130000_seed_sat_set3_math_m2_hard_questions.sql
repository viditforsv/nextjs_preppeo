-- SAT Math Set 3 Module 2: reassign 8 hard questions from practice bank
-- Moves QC-approved practice questions (set_number=0) into set 3 module 2.
-- Gap vs Sets 1 & 2: +4 algebra, +2 geometry-trig, +2 problem-solving
--
-- algebra:         sat_lid_007_29, sat_lid_008_44, sat_lid_012_30, sat_lid_008_34
-- geometry-trig:   sat_lid_050_26, sat_lid_047_39
-- problem-solving: sat_lid_037_37, sat_lid_032_41

UPDATE sat_questions
SET set_number = 3, module_number = 2
WHERE bank_item_id IN (
  'sat_lid_007_29',
  'sat_lid_008_44',
  'sat_lid_012_30',
  'sat_lid_008_34',
  'sat_lid_050_26',
  'sat_lid_047_39',
  'sat_lid_037_37',
  'sat_lid_032_41'
)
AND set_number = 0;
