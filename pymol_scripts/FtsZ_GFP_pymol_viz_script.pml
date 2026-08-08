# ============================================================
# FtsZ-GFP AlphaFold structure inspection in PyMOL
# ============================================================

# Download or construct (FtsZ-GFP) your sequence of interest
# Copy and paste your amino acid seqeunce into alphafold colab notebook to predict structure
# See: https://colab.research.google.com/github/sokrypton/ColabFold/blob/main/AlphaFold2.ipynb
# Save the PDB for visualization in PyMOL

# ------------------------------------------------------------
# 1. Load the AlphaFold PDB file
# ------------------------------------------------------------

load "/home/andrew/Documents/Basic-cheminformatics-analysis/alphafold2_output/test_9611b_unrelaxed_rank_001_alphafold2_ptm_model_3_seed_000.pdb", fusion

# Clean up the initial display
hide everything, fusion
show cartoon, fusion
bg_color white

# Optional: improve cartoon appearance
set cartoon_fancy_helices, 1
set cartoon_smooth_loops, 1


# ------------------------------------------------------------
# 2. Define the protein domains
# ------------------------------------------------------------
# IMPORTANT:
# Replace these residue numbers with the actual boundaries
# in your construct.
#
# Example:
# FtsZ   = residues 1-383
# Linker = residues 384-399
# GFP    = residues 400-638

select ftsz, fusion and resi 1-390
select linker, fusion and resi 391-394
select gfp, fusion and resi 400-643


# ------------------------------------------------------------
# 3. Colour each domain
# ------------------------------------------------------------

color cyan, ftsz
color yellow, linker
color green, gfp

# Make the linker slightly easier to see
show sticks, linker

# Show whole protein
orient fusion


# ------------------------------------------------------------
# 4. Highlight the FtsZ-GFP interface
# ------------------------------------------------------------
# Select residues in FtsZ that come within 4 Angstrom of GFP

select ftsz_interface, byres (ftsz within 4.0 of gfp)

# Select residues in GFP that come within 4 Angstrom of FtsZ

select gfp_interface, byres (gfp within 4.0 of ftsz)


# ------------------------------------------------------------
# 5. Display the interface residues
# ------------------------------------------------------------

show sticks, ftsz_interface
show sticks, gfp_interface

color marine, ftsz_interface
color lime, gfp_interface


# ------------------------------------------------------------
# 6. Optional: show nearby interface atoms as dashed contacts
# ------------------------------------------------------------

distance interface_contacts, \
    ftsz_interface and (name N+O+S), \
    gfp_interface and (name N+O+S), \
    3.5

# Make contact lines thinner
set dash_width, 1.5
set dash_gap, 0.3


# ------------------------------------------------------------
# 7. Zoom to the interface
# ------------------------------------------------------------

zoom ftsz_interface or gfp_interface, 8


# ------------------------------------------------------------
# 8. Optional: label interface residues
# ------------------------------------------------------------
# Uncomment these if you want residue labels.

# label ftsz_interface and name CA, "%s%s" % (resn, resi)
# label gfp_interface and name CA, "%s%s" % (resn, resi)


# ------------------------------------------------------------
# 9. Optional: save a PyMOL session
# ------------------------------------------------------------

save FtsZ_GFP_analysis.pses