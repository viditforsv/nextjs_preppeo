-- ============================================================
--  CBSE 10 Science — Production promotion script
--  Source of truth: DEV Supabase (dxhxpfouzjlzpeazwrqo)
--
--  What this applies:
--   1. Extended domain CHECK constraint
--      (adds periodic-classification, sources-of-energy, sustainable-management)
--   2. Extra columns: is_pyq, pyq_year, correct_answer_b
--   3. New column:    is_flashcard (with partial index)
--   4. Seeds 75 flashcard rows (ON CONFLICT DO NOTHING — safe to re-run)
--
--  Fully idempotent — safe to run even if partially applied.
--  Run in the Supabase prod SQL editor or via:
--    psql $PROD_DB_URL -f scripts/promote_cbse10_science_to_prod.sql
-- ============================================================

BEGIN;

-- ────────────────────────────────────────────────────────────
-- 1. Widen domain CHECK constraint
-- ────────────────────────────────────────────────────────────
ALTER TABLE cbse10_science_questions
  DROP CONSTRAINT IF EXISTS cbse10_science_questions_domain_check;

ALTER TABLE cbse10_science_questions
  ADD CONSTRAINT cbse10_science_questions_domain_check
  CHECK (domain IN (
    'chemical-reactions', 'acids-bases-salts', 'metals-non-metals',
    'carbon-compounds', 'periodic-classification', 'life-processes',
    'control-coordination', 'reproduction', 'heredity-evolution',
    'light', 'human-eye', 'electricity', 'magnetic-effects',
    'sources-of-energy', 'our-environment', 'sustainable-management'
  ));

-- ────────────────────────────────────────────────────────────
-- 2. Extra columns (PYQ + duplicate answer)
-- ────────────────────────────────────────────────────────────
ALTER TABLE cbse10_science_questions
  ADD COLUMN IF NOT EXISTS is_pyq          BOOLEAN NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS pyq_year        TEXT,
  ADD COLUMN IF NOT EXISTS correct_answer_b TEXT;

-- ────────────────────────────────────────────────────────────
-- 3. Flashcard column + index
-- ────────────────────────────────────────────────────────────
ALTER TABLE cbse10_science_questions
  ADD COLUMN IF NOT EXISTS is_flashcard BOOLEAN NOT NULL DEFAULT false;

CREATE INDEX IF NOT EXISTS idx_cbse10_science_flashcards
  ON cbse10_science_questions (domain, chapter)
  WHERE is_flashcard = true;

-- ────────────────────────────────────────────────────────────
-- 4. Seed: 75 flashcards
--    bank_item_id has a UNIQUE index → ON CONFLICT = no-op on re-run
-- ────────────────────────────────────────────────────────────

INSERT INTO cbse10_science_questions (
  type, prompt, correct_answer,
  domain, chapter, difficulty_tier,
  is_active, is_flashcard, qc_done, bank_item_id
) VALUES

-- Chemical Reactions and Equations (28 cards) ────────────────

('spr',
 $fc$In the electrolysis of water, what is the volume ratio of hydrogen gas collected to oxygen gas collected?$fc$,
 $fc$The ratio is $2:1$.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_001'),

('spr',
 $fc$What fundamental law requires that chemical equations be balanced?$fc$,
 $fc$The Law of Conservation of Mass.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_002'),

('spr',
 $fc$What is observed when a copper strip is placed in a silver nitrate solution?$fc$,
 $fc$The solution turns blue and shiny silver metal is deposited.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_003'),

('spr',
 $fc$State one industrial application of the chemical reduction process.$fc$,
 $fc$The extraction of metals from their oxides (e.g., extracting Zinc from Zinc Oxide).$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_004'),

('spr',
 $fc$Why is the burning of wax considered a chemical change while the melting of wax is a physical change?$fc$,
 $fc$Burning produces new substances with new properties, whereas melting only changes the state of the substance.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_005'),

('spr',
 $fc$Term: Oxidation (Electronic concept)$fc$,
 $fc$Definition: A process involving the loss of electrons.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_006'),

('spr',
 $fc$Term: Reduction (Electronic concept)$fc$,
 $fc$Definition: A process involving the gain of electrons.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_007'),

('spr',
 $fc$In a chemical equation, what does a downward-pointing arrow ($\downarrow$) next to a product signify?$fc$,
 $fc$The formation of a precipitate.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_008'),

('spr',
 $fc$In a chemical equation, what does an upward-pointing arrow ($\uparrow$) next to a product signify?$fc$,
 $fc$The evolution of a gas.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_009'),

('spr',
 $fc$Why can water extinguish fire even though its constituent elements (Hydrogen and Oxygen) are highly flammable or support combustion?$fc$,
 $fc$As a compound, water possesses entirely different properties than its constituent elements.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_010'),

('spr',
 $fc$What is the composition and color of the coating formed when copper metal is heated in air?$fc$,
 $fc$A black coating of copper oxide ($\mathrm{CuO}$).$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_011'),

('spr',
 $fc$Write the balanced chemical equation for the formation of methyl alcohol from carbon monoxide and hydrogen gas.$fc$,
 $fc$$\mathrm{CO}(\mathrm{g}) + 2\mathrm{H}_{2}(\mathrm{g}) \xrightarrow{340 \text{ atm}} \mathrm{CH}_{3}\mathrm{OH}(\mathrm{l})$$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_012'),

('spr',
 $fc$Identify the type of reaction: $\mathrm{AgNO}_{3}(\mathrm{aq}) + \mathrm{NaCl}(\mathrm{aq}) \longrightarrow \mathrm{AgCl}(\mathrm{s}) + \mathrm{NaNO}_{3}(\mathrm{aq})$$fc$,
 $fc$Precipitation (or Double Displacement) reaction.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_013'),

('spr',
 $fc$What is the primary difference between exothermic and endothermic reactions?$fc$,
 $fc$Exothermic reactions evolve heat, while endothermic reactions absorb heat.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_014'),

('spr',
 $fc$What are the products when quicklime ($\mathrm{CaO}$) reacts with water?$fc$,
 $fc$Calcium hydroxide (Slaked lime) and heat.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_015'),

('spr',
 $fc$The chemical reaction $2\mathrm{AgCl}(\mathrm{s}) \xrightarrow{\text{sunlight}} 2\mathrm{Ag}(\mathrm{s}) + \mathrm{Cl}_{2}(\mathrm{g})$ is an example of what specific type of decomposition?$fc$,
 $fc$Photochemical decomposition.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_016'),

('spr',
 $fc$What is a displacement reaction?$fc$,
 $fc$A reaction where a more reactive element displaces a less reactive element from its compound.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_017'),

('spr',
 $fc$Identify the substance oxidised in the reaction: $\mathrm{CuO} + \mathrm{H}_{2} \longrightarrow \mathrm{Cu} + \mathrm{H}_{2}O$.$fc$,
 $fc$Hydrogen ($\mathrm{H}_{2}$).$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_018'),

('spr',
 $fc$What compound imparts a blue-green color to the solution when dilute hydrochloric acid is added to copper oxide?$fc$,
 $fc$Copper chloride ($\mathrm{CuCl}_{2}$).$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_019'),

('spr',
 $fc$Why is respiration classified as an exothermic process?$fc$,
 $fc$Because energy is released during the process of respiration.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_020'),

('spr',
 $fc$Which two silver salts are commonly used in black and white photography?$fc$,
 $fc$Silver bromide ($\mathrm{AgBr}$) and Silver chloride ($\mathrm{AgCl}$) [or Silver iodide ($\mathrm{AgI}$)].$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_021'),

('spr',
 $fc$What color change occurs when pale green ferrous sulphate crystals are heated strongly?$fc$,
 $fc$They turn dirty white (loss of water) and eventually reddish-brown (formation of ferric oxide).$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_022'),

('spr',
 $fc$What is a ''Redox'' reaction?$fc$,
 $fc$A reaction in which oxidation and reduction occur simultaneously.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_023'),

('spr',
 $fc$Why is the Thermite reaction ($2\mathrm{Al} + \mathrm{Fe}_{2}\mathrm{O}_{3} \rightarrow \mathrm{Al}_{2}\mathrm{O}_{3} + 2\mathrm{Fe}$) used in railway engineering?$fc$,
 $fc$To join railway tracks or repair cracked machine parts by producing molten iron.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_024'),

('spr',
 $fc$What happens to lime water when $\mathrm{CO}_{2}$ gas is bubbled through it in excess?$fc$,
 $fc$The initially formed milkiness disappears due to the formation of soluble calcium bicarbonate.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_025'),

('spr',
 $fc$How does the reactivity of Zinc compare to Copper, as evidenced by their reaction in copper sulphate solution?$fc$,
 $fc$Zinc is more reactive than copper because it displaces copper from its solution.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_026'),

('spr',
 $fc$Why are silver salts stored in dark-colored bottles?$fc$,
 $fc$To prevent their decomposition by exposure to sunlight.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_027'),

('spr',
 $fc$Identify the type of reaction: $\mathrm{NaOH} + \mathrm{HCl} \longrightarrow \mathrm{NaCl} + \mathrm{H}_{2}O$.$fc$,
 $fc$Neutralisation (or Double Displacement) reaction.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_028'),

-- Electricity (30 cards, rows 29–58) ────────────────────────

('spr',
 $fc$What is the charge of a single electron?$fc$,
 $fc$$-1.6 \times 10^{-19} \text{ C}$.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_029'),

('spr',
 $fc$Approximately how many electrons constitute $1 \text{ Coulomb}$ of charge?$fc$,
 $fc$$6.25 \times 10^{18}$ electrons.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_030'),

('spr',
 $fc$Conductor resistance is _____ proportional to its length.$fc$,
 $fc$Directly$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_031'),

('spr',
 $fc$Conductor resistance is _____ proportional to its area of cross-section.$fc$,
 $fc$Inversely$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_032'),

('spr',
 $fc$What is the SI unit of electric potential?$fc$,
 $fc$Volt (V).$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_033'),

('spr',
 $fc$State Ohm''s Law.$fc$,
 $fc$Current through a conductor is directly proportional to the potential difference across its ends, provided physical conditions like temperature remain constant.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_034'),

('spr',
 $fc$Why is tungsten specifically chosen for electric lamp filaments?$fc$,
 $fc$Because it has a very high melting point and high resistivity.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_035'),

('spr',
 $fc$How must an ammeter be connected in a circuit to measure current?$fc$,
 $fc$In series.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_036'),

('spr',
 $fc$How must a voltmeter be connected in a circuit to measure potential difference?$fc$,
 $fc$In parallel.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_037'),

('spr',
 $fc$What is the relationship between the direction of conventional current and electron flow?$fc$,
 $fc$They are opposite to each other (conventional current flows from positive to negative).$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_038'),

('spr',
 $fc$How does the resistivity of an alloy generally compare to its constituent pure metals?$fc$,
 $fc$Alloys generally have higher resistivity than their constituent pure metals.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_039'),

('spr',
 $fc$What is the SI unit of resistivity?$fc$,
 $fc$Ohm-meter ($\Omega\cdot\text{m}$).$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_040'),

('spr',
 $fc$What are the two key properties required for a fuse wire?$fc$,
 $fc$Low resistance and a low melting point.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_041'),

('spr',
 $fc$Why are copper and aluminium preferred for electrical transmission lines?$fc$,
 $fc$Due to their very low resistivity.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_042'),

('spr',
 $fc$What is an ''open'' electric circuit?$fc$,
 $fc$A circuit in which the switch is off, resulting in no current flow.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_043'),

('spr',
 $fc$How can one obtain the lowest possible total resistance from a set of resistors?$fc$,
 $fc$By connecting them in parallel combination.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_044'),

('spr',
 $fc$If the length of a conductor is reduced to half, what happens to its resistance?$fc$,
 $fc$The resistance is also reduced to half.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_045'),

('spr',
 $fc$How does increasing the temperature affect the resistance of a metallic conductor?$fc$,
 $fc$The resistance increases as temperature rises.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_046'),

('spr',
 $fc$Between a $1 \text{ kW}$ toaster and a $2 \text{ kW}$ heater (at the same voltage), which has higher resistance?$fc$,
 $fc$The $1 \text{ kW}$ toaster (Resistance is inversely proportional to Power when Voltage is constant).$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_047'),

('spr',
 $fc$Formula: Resistivity ($\rho$) in terms of Resistance ($R$), Length ($l$), and Area ($A$)$fc$,
 $fc$$\rho = R \cdot \frac{A}{l}$$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_048'),

('spr',
 $fc$What is the resistance of an ideal voltmeter?$fc$,
 $fc$Infinite.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_049'),

('spr',
 $fc$What is the resistance of an ideal ammeter?$fc$,
 $fc$Zero (or very low).$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_050'),

('spr',
 $fc$State Joule''s Law of Heating in formula form.$fc$,
 $fc$$H = I^{2}Rt$ (where $H$ is heat, $I$ is current, $R$ is resistance, and $t$ is time).$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_051'),

('spr',
 $fc$Why do alloys like Nichrome not burn (oxidise) even at high temperatures?$fc$,
 $fc$Because they have a high melting point and resist oxidation at high temperatures.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_052'),

('spr',
 $fc$A wire of resistance $R$ is stretched to double its length; what is the new resistance?$fc$,
 $fc$$4R$ (Resistance increases by the square of the length increase during stretching).$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_053'),

('spr',
 $fc$What happens to the current in a circuit if the resistance is doubled and voltage remains constant?$fc$,
 $fc$The current is halved.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_054'),

('spr',
 $fc$Identify the instrument symbol: A circle with the letter ''V'' inside it.$fc$,
 $fc$Voltmeter.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_055'),

('spr',
 $fc$Identify the instrument symbol: A zig-zag line with an arrow pointing through or over it.$fc$,
 $fc$Rheostat (Variable Resistor).$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_056'),

('spr',
 $fc$In a series circuit, how does the current passing through various resistors compare?$fc$,
 $fc$The current is the same through all resistors in series.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_057'),

('spr',
 $fc$In a parallel circuit, how does the potential difference across different resistors compare?$fc$,
 $fc$The potential difference is the same across all resistors in parallel.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_058'),

-- Chemical Reactions cont. (row 59) ──────────────────────────

('spr',
 $fc$What are the three main products of the thermal decomposition of ferrous sulphate?$fc$,
 $fc$Ferric oxide ($\mathrm{Fe}_{2}\mathrm{O}_{3}$), Sulphur dioxide ($\mathrm{SO}_{2}$), and Sulphur trioxide ($\mathrm{SO}_{3}$).$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_059'),

-- Electricity cont. (rows 60–61, 63–65, 72–75) ───────────────

('spr',
 $fc$Formula: Total resistance ($R_s$) for resistors in series.$fc$,
 $fc$$R_s = R_1 + R_2 + R_3 + \dots$$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_060'),

('spr',
 $fc$Formula: Total resistance ($R_p$) for resistors in parallel.$fc$,
 $fc$$\frac{1}{R_p} = \frac{1}{R_1} + \frac{1}{R_2} + \frac{1}{R_3} + \dots$$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_061'),

-- Chemical Reactions cont. (row 62) ──────────────────────────

('spr',
 $fc$What observation confirms that a gas evolved in a reaction is hydrogen?$fc$,
 $fc$It burns with a ''pop'' sound when a burning splinter is brought near it.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_062'),

-- Electricity cont. ───────────────────────────────────────────

('spr',
 $fc$Define potential difference of 1 Volt.$fc$,
 $fc$The potential difference between two points when 1 Joule of work is done to move 1 Coulomb of charge between them.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_063'),

('spr',
 $fc$How does the thickness of a wire affect its electrical resistance?$fc$,
 $fc$Thicker wires have lower resistance (Area is larger, so $R$ is smaller).$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_064'),

('spr',
 $fc$What is the power of an electrical device consuming $60 \text{ Joules}$ of energy in $1 \text{ second}$?$fc$,
 $fc$$60 \text{ Watts}$.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_065'),

-- Chemical Reactions cont. (rows 66–71) ──────────────────────

('spr',
 $fc$Name the process where a single reactant breaks down to give simpler products.$fc$,
 $fc$Decomposition reaction.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_066'),

('spr',
 $fc$In the reaction $\mathrm{MnO}_{2} + 4\mathrm{HCl} \rightarrow \mathrm{MnCl}_{2} + \mathrm{Cl}_{2} + 2\mathrm{H}_{2}O$, which substance is reduced?$fc$,
 $fc$Manganese dioxide ($\mathrm{MnO}_{2}$).$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_067'),

('spr',
 $fc$What condition must be met for a skeleton chemical equation to be considered ''balanced''?$fc$,
 $fc$The number of atoms of each element must be equal on both the reactant and product sides.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_068'),

('spr',
 $fc$A solution of potassium iodide added to lead nitrate produces a _____ precipitate.$fc$,
 $fc$Yellow (of Lead Iodide)$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_069'),

('spr',
 $fc$What is the primary cause of the corrosion of the Taj Mahal marble?$fc$,
 $fc$Reaction of calcium carbonate with acid rain (containing $\mathrm{H}_{2}\mathrm{SO}_{4}$ and $\mathrm{HNO}_{3}$) from industrial pollution.$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_070'),

('spr',
 $fc$Which is more reactive: Aluminum or Manganese?$fc$,
 $fc$Aluminum (it displaces Manganese from its oxide).$fc$,
 'chemical-reactions','Chemical Reactions and Equations','easy',true,true,true,'cbse10_fc_071'),

-- Electricity cont. (rows 72–75) ─────────────────────────────

('spr',
 $fc$What is the SI unit of electric current?$fc$,
 $fc$Ampere (A).$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_072'),

('spr',
 $fc$Define 1 Ampere in terms of charge and time.$fc$,
 $fc$The flow of 1 Coulomb of charge per second ($1 \text{ A} = 1 \text{ C/s}$).$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_073'),

('spr',
 $fc$How does the slope of a V-I graph relate to the resistance of a conductor?$fc$,
 $fc$The slope (or its inverse, depending on axes) represents the Resistance ($R = V/I$).$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_074'),

('spr',
 $fc$Why do the connecting wires of an electric heater not glow, while the heating element does?$fc$,
 $fc$Connecting wires have very low resistance, while the heating element has high resistance and produces significant heat.$fc$,
 'electricity','Electricity','easy',true,true,true,'cbse10_fc_075')

ON CONFLICT (bank_item_id) DO NOTHING;

COMMIT;
