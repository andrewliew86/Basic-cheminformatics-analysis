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

load "C:\Users\Andrew\Documents\Learning coding notes\my_work_dir\Cheminformatics-pymol-molecular-viz\alphafold2_output\test_9611b_unrelaxed_rank_001_alphafold2_ptm_model_3_seed_000.pdb", fusion

# Clean up the initial display
hide everything, fusion
show cartoon, fusion
bg_color white


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
select linker, fusion and resi 391-399
select gfp, fusion and resi 400-643


# ------------------------------------------------------------
# 3. Colour each domain
# ------------------------------------------------------------

color cyan, ftsz
color yellow, linker
color green, gfp

# Make the linker slightly easier to see
show sticks, linker

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
# 7. Zoom to fusion
# ------------------------------------------------------------

orient fusion
zoom fusion, 5

# ------------------------------------------------------------
# 8. Optional: label interface residues
# ------------------------------------------------------------
# Uncomment these if you want residue labels.

# label ftsz_interface and name CA, "%s%s" % (resn, resi)
# label gfp_interface and name CA, "%s%s" % (resn, resi)


# ------------------------------------------------------------
# Final rendering settings
# ------------------------------------------------------------

set antialias, 2
set depth_cue, 0

set specular, 0.2
set shininess, 10
set ambient, 0.4
set direct, 0.6

# Black outline
set ray_trace_mode, 1
set ray_trace_color, black

# Stronger outline
set ray_trace_gain, 0.5
set ray_trace_disco_factor, 1.0

# save session AFTER rendering
save FtsZ_GFP_analysis.pse

# RENDER FINAL SCENE
ray 2400, 1800

# Then save the ray-traced image
png ftsz_gfp.png, dpi=300