# Set working directory
cd C:/Users/Andrew/Documents/Learning coding notes/my_work_dir/Cheminformatics-pymol-molecular-viz

### Fetch PC190723 bound to SaFtsZ structure from PDB then show inhibtor as sticks and yellow
fetch 4dxd
hide everything
bg_color white
show cartoon, polymer
color cyan, polymer
select inhibitor, resn 9PC
show sticks, inhibitor
color yellow, inhibitor

### Color the pockets so it is easy to see
select pocket, byres (polymer within 5 of inhibitor)
show sticks, pocket
color marine, pocket

### We will seperate then save the inhibitor and FtsZ respectively for downstream molecular docking
save pdb_files/pc190723.pdb, inhibitor
save pdb_files/ftsz.pdb, polymer

### Orientate your image for nice visuals
# Orient finds a sensible view for you to take an image. Here it is focusing on the whole molecule
orient 4dxd
# Uncomment below to zoom on inhibitor abd pocket
#zoom inhibitor, 2

### Final visual clean-up 
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
save pse_files/FtsZ_PC190723_analysis.pse

# RENDER FINAL SCENE
ray 2400, 1800

# Then save the ray-traced image
png images/ftsz_PC190723.png, dpi=300