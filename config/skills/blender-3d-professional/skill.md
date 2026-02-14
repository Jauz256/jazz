# Professional 3D Model Creation in Blender

## Purpose

This skill provides techniques, workflows, and Blender Python code to create professional-quality 3D models. It serves as a reference guide for producing high-quality assets that match industry standards.

## When to Use This Skill

Activate when user asks to:
- Create a 3D model/asset
- Make a flower, plant, or organic object
- Design something for Three.js/WebGL
- Build a Blender project
- Export to glTF/GLB

---

## PART 1: Professional Model Anatomy

### 1.1 What Makes a Model "Professional"

```
PROFESSIONAL MODEL CHARACTERISTICS:
├── Unified mesh (not separate objects)
├── Clean topology (quad-based, good edge flow)
├── High vertex count for organic shapes (50k-200k)
├── UV coordinates for texturing
├── PBR materials (baseColor, normal, roughness)
├── Proper normals (smooth shading, no artifacts)
└── Optimized for target platform
```

### 1.2 Reference: Professional Rose Structure

```
Analyzed model: Rose by Heliona (Sketchfab)

MESH STRUCTURE:
- Petals: 54,883 vertices (ONE unified mesh)
- Stem: 7,386 vertices
- Leaves: 7,158 vertices
- Thorns: 1,494 vertices
- Total: 70,921 vertices, ~120k triangles

TEXTURES (per component):
- baseColor.jpeg (color/albedo)
- normal.png (surface detail)
- metallicRoughness.png (material properties)

KEY INSIGHT: All petals are ONE sculpted mesh, not separate objects
```

---

## PART 2: Blender Python Techniques

### 2.1 Creating Smooth Organic Shapes

**WRONG approach (what I did before):**
```python
# Creates angular, geometric results
bpy.ops.mesh.primitive_plane_add()
for v in mesh.verts:
    v.co.z = sin(v.co.y) * curl  # Mathematical = artificial
```

**RIGHT approach:**
```python
# Use Bezier curves for organic shapes
def create_organic_petal():
    # Create curve-based shape
    bpy.ops.curve.primitive_bezier_curve_add()
    curve = bpy.context.object

    # Add control points for organic shape
    spline = curve.data.splines[0]
    spline.bezier_points.add(3)

    # Shape with smooth handles (not mathematical formulas)
    points = spline.bezier_points
    points[0].co = Vector((0, 0, 0))
    points[0].handle_right_type = 'AUTO'
    points[1].co = Vector((0.02, 0.03, 0.01))
    points[1].handle_left_type = 'AUTO'
    points[1].handle_right_type = 'AUTO'
    # ... more points with AUTO handles for smooth curves

    # Convert to mesh with high resolution
    curve.data.resolution_u = 32
    curve.data.bevel_depth = 0.01
    curve.data.bevel_resolution = 12

    bpy.ops.object.convert(target='MESH')
```

### 2.2 Sculpting via Python

```python
def sculpt_organic_detail(obj):
    """Apply sculpt-like deformation programmatically"""

    bpy.context.view_layer.objects.active = obj
    bpy.ops.object.mode_set(mode='SCULPT')

    # Enable dyntopo for adaptive detail
    bpy.ops.sculpt.dynamic_topology_toggle()
    bpy.context.scene.tool_settings.sculpt.detail_size = 6

    # Use smooth brush programmatically
    bpy.ops.sculpt.brush_stroke(
        stroke=[{
            "name": "smooth",
            "location": (0, 0, 0),
            "size": 50,
            "pressure": 0.5
        }]
    )

    bpy.ops.object.mode_set(mode='OBJECT')
```

### 2.3 Creating Unified Mesh (Not Separate Objects)

```python
def join_into_unified_mesh(objects):
    """Join multiple objects into one unified mesh"""

    # Select all objects
    bpy.ops.object.select_all(action='DESELECT')
    for obj in objects:
        obj.select_set(True)

    # Set active object
    bpy.context.view_layer.objects.active = objects[0]

    # Join into single mesh
    bpy.ops.object.join()

    # Remove doubles (merge close vertices)
    bpy.ops.object.mode_set(mode='EDIT')
    bpy.ops.mesh.select_all(action='SELECT')
    bpy.ops.mesh.remove_doubles(threshold=0.0001)

    # Recalculate normals for smooth shading
    bpy.ops.mesh.normals_make_consistent(inside=False)
    bpy.ops.object.mode_set(mode='OBJECT')

    # Apply smooth shading
    bpy.ops.object.shade_smooth()

    return bpy.context.object
```

### 2.4 Proper Subdivision Surface

```python
def add_subdivision(obj, levels=2, render_levels=3):
    """Add subdivision surface for smooth results"""

    # Add modifier
    subsurf = obj.modifiers.new(name="Subdivision", type='SUBSURF')
    subsurf.levels = levels
    subsurf.render_levels = render_levels
    subsurf.quality = 3
    subsurf.uv_smooth = 'PRESERVE_CORNERS'
    subsurf.boundary_smooth = 'ALL'

    # IMPORTANT: Apply modifier before export
    bpy.context.view_layer.objects.active = obj
    bpy.ops.object.modifier_apply(modifier="Subdivision")
```

---

## PART 3: UV Unwrapping

### 3.1 Automatic UV Unwrapping

```python
def auto_unwrap_uv(obj):
    """Create UV coordinates for texturing"""

    bpy.context.view_layer.objects.active = obj
    bpy.ops.object.mode_set(mode='EDIT')
    bpy.ops.mesh.select_all(action='SELECT')

    # Smart UV project (good for organic shapes)
    bpy.ops.uv.smart_project(
        angle_limit=66.0,
        island_margin=0.02,
        area_weight=0.0,
        correct_aspect=True,
        scale_to_bounds=True
    )

    bpy.ops.object.mode_set(mode='OBJECT')
```

### 3.2 Mark Seams for Better Unwrap

```python
def mark_seams_by_angle(obj, angle_threshold=60):
    """Mark seams at sharp edges for better UV unwrap"""

    bpy.context.view_layer.objects.active = obj
    bpy.ops.object.mode_set(mode='EDIT')
    bpy.ops.mesh.select_all(action='DESELECT')

    # Select sharp edges
    bpy.ops.mesh.edges_select_sharp(sharpness=math.radians(angle_threshold))

    # Mark as seams
    bpy.ops.mesh.mark_seam(clear=False)

    # Now unwrap
    bpy.ops.mesh.select_all(action='SELECT')
    bpy.ops.uv.unwrap(method='ANGLE_BASED', margin=0.02)

    bpy.ops.object.mode_set(mode='OBJECT')
```

---

## PART 4: PBR Materials

### 4.1 Create PBR Material with Nodes

```python
def create_pbr_material(name, base_color, roughness=0.5, metallic=0.0):
    """Create physically-based material"""

    mat = bpy.data.materials.new(name=name)
    mat.use_nodes = True
    nodes = mat.node_tree.nodes
    links = mat.node_tree.links

    # Clear defaults
    nodes.clear()

    # Create nodes
    output = nodes.new('ShaderNodeOutputMaterial')
    output.location = (400, 0)

    principled = nodes.new('ShaderNodeBsdfPrincipled')
    principled.location = (0, 0)

    # Set base properties
    principled.inputs['Base Color'].default_value = base_color
    principled.inputs['Roughness'].default_value = roughness
    principled.inputs['Metallic'].default_value = metallic

    # Connect
    links.new(principled.outputs['BSDF'], output.inputs['Surface'])

    return mat
```

### 4.2 PBR Material with Subsurface Scattering (for petals)

```python
def create_petal_material(name, color):
    """Create realistic petal material with translucency"""

    mat = bpy.data.materials.new(name=name)
    mat.use_nodes = True
    nodes = mat.node_tree.nodes
    links = mat.node_tree.links
    nodes.clear()

    output = nodes.new('ShaderNodeOutputMaterial')
    output.location = (600, 0)

    principled = nodes.new('ShaderNodeBsdfPrincipled')
    principled.location = (200, 0)

    # Petal-specific settings
    principled.inputs['Base Color'].default_value = color
    principled.inputs['Roughness'].default_value = 0.4
    principled.inputs['Metallic'].default_value = 0.0

    # Subsurface scattering (light through petals)
    principled.inputs['Subsurface Weight'].default_value = 0.3
    principled.inputs['Subsurface Radius'].default_value = (0.1, 0.05, 0.02)

    # Slight sheen for velvet look
    principled.inputs['Sheen Weight'].default_value = 0.1

    links.new(principled.outputs['BSDF'], output.inputs['Surface'])

    return mat
```

### 4.3 Add Texture Maps to Material

```python
def add_texture_to_material(mat, texture_path, input_name='Base Color'):
    """Add image texture to material"""

    nodes = mat.node_tree.nodes
    links = mat.node_tree.links

    # Get principled node
    principled = None
    for node in nodes:
        if node.type == 'BSDF_PRINCIPLED':
            principled = node
            break

    if not principled:
        return

    # Create image texture node
    tex_node = nodes.new('ShaderNodeTexImage')
    tex_node.location = (-300, 0)
    tex_node.image = bpy.data.images.load(texture_path)

    # Connect to appropriate input
    links.new(tex_node.outputs['Color'], principled.inputs[input_name])
```

---

## PART 5: Procedural Textures (No External Files)

### 5.1 Procedural Color Variation

```python
def create_procedural_petal_material(name, base_color, edge_color):
    """Create petal with color gradient (no texture files needed)"""

    mat = bpy.data.materials.new(name=name)
    mat.use_nodes = True
    nodes = mat.node_tree.nodes
    links = mat.node_tree.links
    nodes.clear()

    # Output
    output = nodes.new('ShaderNodeOutputMaterial')
    output.location = (800, 0)

    # Principled BSDF
    principled = nodes.new('ShaderNodeBsdfPrincipled')
    principled.location = (500, 0)

    # Color ramp for gradient
    ramp = nodes.new('ShaderNodeValToRGB')
    ramp.location = (200, 0)
    ramp.color_ramp.elements[0].color = base_color
    ramp.color_ramp.elements[1].color = edge_color

    # Geometry node for position-based gradient
    geometry = nodes.new('ShaderNodeNewGeometry')
    geometry.location = (-200, 0)

    # Use pointiness for edge detection
    links.new(geometry.outputs['Pointiness'], ramp.inputs['Fac'])
    links.new(ramp.outputs['Color'], principled.inputs['Base Color'])
    links.new(principled.outputs['BSDF'], output.inputs['Surface'])

    # Subsurface
    principled.inputs['Subsurface Weight'].default_value = 0.25
    principled.inputs['Roughness'].default_value = 0.4

    return mat
```

### 5.2 Procedural Normal Map (Bump)

```python
def add_procedural_bump(mat, strength=0.1):
    """Add procedural surface detail without texture files"""

    nodes = mat.node_tree.nodes
    links = mat.node_tree.links

    principled = None
    for node in nodes:
        if node.type == 'BSDF_PRINCIPLED':
            principled = node
            break

    # Noise texture for organic variation
    noise = nodes.new('ShaderNodeTexNoise')
    noise.location = (-400, -200)
    noise.inputs['Scale'].default_value = 50.0
    noise.inputs['Detail'].default_value = 8.0

    # Bump node
    bump = nodes.new('ShaderNodeBump')
    bump.location = (-100, -200)
    bump.inputs['Strength'].default_value = strength

    links.new(noise.outputs['Fac'], bump.inputs['Height'])
    links.new(bump.outputs['Normal'], principled.inputs['Normal'])
```

---

## PART 6: Complete Flower Creation Workflow

### 6.1 Professional Petal Creation

```python
import bpy
import bmesh
import math
from mathutils import Vector, Euler, noise
import random

def create_professional_petal(name, length=0.05, width=0.03, curl=0.3, subdivisions=4):
    """
    Create a high-quality petal using professional techniques:
    1. Start with bezier curve for smooth base shape
    2. Convert to mesh with high resolution
    3. Apply organic deformation with noise
    4. Subdivide for smoothness
    5. Add proper UV coordinates
    """

    # --- STEP 1: Create base shape with Bezier curve ---
    bpy.ops.curve.primitive_bezier_curve_add()
    curve = bpy.context.object
    curve.name = f"{name}_curve"

    # Configure curve for petal cross-section
    curve.data.dimensions = '3D'
    curve.data.resolution_u = 24
    curve.data.fill_mode = 'FULL'
    curve.data.bevel_depth = width / 2
    curve.data.bevel_resolution = 8

    # Shape the curve (petal length profile)
    spline = curve.data.splines[0]
    points = spline.bezier_points

    # Base of petal
    points[0].co = Vector((0, 0, 0))
    points[0].handle_right = Vector((0, length * 0.3, curl * 0.1))
    points[0].handle_left = Vector((0, -0.01, 0))

    # Tip of petal
    points[1].co = Vector((0, length, curl * length))
    points[1].handle_left = Vector((0, length * 0.7, curl * length * 0.3))
    points[1].handle_right = Vector((0, length * 1.1, curl * length * 1.2))

    # Add middle control point for better shape
    spline.bezier_points.add(1)
    points = spline.bezier_points
    points[1].co = Vector((0, length * 0.6, curl * length * 0.2))
    points[1].handle_left_type = 'AUTO'
    points[1].handle_right_type = 'AUTO'

    # Move tip to last position
    points[2].co = Vector((0, length, curl * length * 0.8))
    points[2].handle_left_type = 'AUTO'
    points[2].handle_right_type = 'AUTO'

    # --- STEP 2: Convert to mesh ---
    bpy.ops.object.convert(target='MESH')
    petal = bpy.context.object
    petal.name = name

    # --- STEP 3: Apply organic deformation ---
    bpy.ops.object.mode_set(mode='EDIT')
    bm = bmesh.from_edit_mesh(petal.data)

    for v in bm.verts:
        # Get normalized position
        y_norm = v.co.y / length if length > 0 else 0
        x_norm = v.co.x / (width / 2) if width > 0 else 0

        # Cup shape (edges curve up)
        cup = (abs(x_norm) ** 2) * 0.02 * (0.5 + y_norm * 0.5)
        v.co.z += cup

        # Organic noise variation
        noise_val = noise.noise(v.co * 20) * 0.002
        v.co.z += noise_val

        # Taper at base and tip
        if y_norm < 0.2:
            taper = y_norm / 0.2
            v.co.x *= taper
        elif y_norm > 0.85:
            taper = (1.0 - y_norm) / 0.15
            v.co.x *= 0.7 + 0.3 * taper

    bmesh.update_edit_mesh(petal.data)
    bpy.ops.object.mode_set(mode='OBJECT')

    # --- STEP 4: Subdivide for smoothness ---
    subsurf = petal.modifiers.new(name="Subsurf", type='SUBSURF')
    subsurf.levels = subdivisions
    subsurf.render_levels = subdivisions + 1
    bpy.ops.object.modifier_apply(modifier="Subsurf")

    # --- STEP 5: Add UV coordinates ---
    bpy.ops.object.mode_set(mode='EDIT')
    bpy.ops.mesh.select_all(action='SELECT')
    bpy.ops.uv.smart_project(angle_limit=66, island_margin=0.02)
    bpy.ops.object.mode_set(mode='OBJECT')

    # Smooth shading
    bpy.ops.object.shade_smooth()

    return petal
```

### 6.2 Assemble Flower with Proper Structure

```python
def create_professional_flower(name="Flower", petal_count=12, layers=3):
    """
    Create complete flower using professional techniques:
    1. Create petals using bezier curves
    2. Arrange in natural spiral pattern
    3. Join into unified mesh
    4. Apply professional material
    """

    all_petals = []
    golden_angle = 137.5 * math.pi / 180  # Natural spiral

    for layer in range(layers):
        # Each layer has different properties
        layer_petal_count = petal_count + layer * 4
        layer_size = 0.6 + layer * 0.2
        layer_curl = 0.5 - layer * 0.1
        layer_tilt = 0.3 + layer * 0.25
        layer_radius = 0.01 + layer * 0.015
        layer_z = 0.01 - layer * 0.008

        for i in range(layer_petal_count):
            # Create petal
            petal = create_professional_petal(
                name=f"{name}_petal_{layer}_{i}",
                length=0.04 * layer_size,
                width=0.025 * layer_size,
                curl=layer_curl,
                subdivisions=3
            )

            # Position in spiral
            angle = i * golden_angle + layer * 0.5

            # Add natural variation
            angle += random.uniform(-0.1, 0.1)
            tilt = layer_tilt + random.uniform(-0.05, 0.05)

            petal.rotation_euler = Euler((tilt, random.uniform(-0.03, 0.03), angle))
            petal.location = (
                math.cos(angle) * layer_radius,
                math.sin(angle) * layer_radius,
                layer_z + random.uniform(-0.002, 0.002)
            )

            all_petals.append(petal)

    # --- Join into unified mesh ---
    bpy.ops.object.select_all(action='DESELECT')
    for petal in all_petals:
        petal.select_set(True)
    bpy.context.view_layer.objects.active = all_petals[0]
    bpy.ops.object.join()

    flower = bpy.context.object
    flower.name = name

    # Clean up mesh
    bpy.ops.object.mode_set(mode='EDIT')
    bpy.ops.mesh.select_all(action='SELECT')
    bpy.ops.mesh.remove_doubles(threshold=0.0001)
    bpy.ops.mesh.normals_make_consistent(inside=False)
    bpy.ops.object.mode_set(mode='OBJECT')

    # Apply material
    mat = create_procedural_petal_material(
        f"{name}_material",
        base_color=(0.8, 0.1, 0.15, 1.0),  # Deep red
        edge_color=(0.95, 0.3, 0.35, 1.0)   # Light pink edges
    )
    flower.data.materials.append(mat)

    return flower
```

---

## PART 7: Export Settings

### 7.1 Export to glTF/GLB

```python
def export_to_gltf(filepath, selected_only=True):
    """Export model with optimal settings for web"""

    bpy.ops.export_scene.gltf(
        filepath=filepath,
        export_format='GLB',  # Single file
        use_selection=selected_only,
        export_apply=True,  # Apply modifiers
        export_texcoords=True,  # Include UVs
        export_normals=True,
        export_colors=True,
        export_materials='EXPORT',
        export_cameras=False,
        export_lights=False,
        export_extras=False,
        export_yup=True,  # Y-up for Three.js
    )
```

### 7.2 Optimize Before Export

```python
def optimize_for_web(obj, target_triangles=50000):
    """Reduce polygon count while preserving quality"""

    bpy.context.view_layer.objects.active = obj

    # Add decimate modifier
    decimate = obj.modifiers.new(name="Decimate", type='DECIMATE')
    decimate.decimate_type = 'COLLAPSE'

    # Calculate ratio
    current_faces = len(obj.data.polygons)
    if current_faces > target_triangles:
        decimate.ratio = target_triangles / current_faces

    # Apply
    bpy.ops.object.modifier_apply(modifier="Decimate")

    # Recalculate normals
    bpy.ops.object.mode_set(mode='EDIT')
    bpy.ops.mesh.normals_make_consistent(inside=False)
    bpy.ops.object.mode_set(mode='OBJECT')
```

---

## PART 8: Complete Script Template

```python
"""
Professional Flower Generator
Usage: Run in Blender via Scripting tab or command line
"""

import bpy
import bmesh
import math
from mathutils import Vector, Euler, noise
import random

# Clear scene
bpy.ops.object.select_all(action='SELECT')
bpy.ops.object.delete()

# Set seed for reproducibility
random.seed(42)

# === CONFIGURATION ===
FLOWER_NAME = "ProfessionalFlower"
PETAL_LAYERS = 4
PETALS_PER_LAYER = 8
OUTPUT_PATH = "/path/to/output/flower.glb"

# === COLORS ===
BASE_COLOR = (0.8, 0.12, 0.18, 1.0)    # Deep red
EDGE_COLOR = (0.95, 0.35, 0.40, 1.0)   # Light pink
STEM_COLOR = (0.12, 0.30, 0.12, 1.0)   # Green

# [Include all functions from above sections here]

# === MAIN ===
if __name__ == "__main__":
    # Create flower
    flower = create_professional_flower(
        name=FLOWER_NAME,
        petal_count=PETALS_PER_LAYER,
        layers=PETAL_LAYERS
    )

    # Create stem (optional)
    # stem = create_stem()

    # Optimize
    optimize_for_web(flower, target_triangles=80000)

    # Export
    flower.select_set(True)
    export_to_gltf(OUTPUT_PATH)

    print(f"Exported: {OUTPUT_PATH}")
```

---

## PART 9: Quality Checklist

Before considering a model "professional quality", verify:

```
GEOMETRY:
☐ Unified mesh (not separate objects)
☐ No overlapping faces
☐ No flipped normals
☐ Smooth shading applied
☐ Sufficient vertex count (50k+ for organic)

MATERIALS:
☐ PBR material setup
☐ Subsurface scattering for organic materials
☐ Color variation (not flat solid color)
☐ Appropriate roughness values

UVs:
☐ UV coordinates exist
☐ No stretching or distortion
☐ Proper island margins

EXPORT:
☐ Applied all modifiers
☐ Included normals and UVs
☐ File size appropriate (<10MB for web)
```

---

## Summary

**Key differences from failed approaches:**

| Failed Approach | Professional Approach |
|-----------------|----------------------|
| Primitive planes | Bezier curves converted to mesh |
| Mathematical sin/cos | Noise-based organic variation |
| Separate objects | Unified joined mesh |
| No UVs | Smart UV project |
| Solid colors | Procedural gradients + SSS |
| Low subdivision | High subdivision (3-4 levels) |

**Always remember:**
1. Use curves for base shapes, not primitives
2. Add noise/randomness for organic feel
3. Join all parts into unified mesh
4. Include UV coordinates
5. Use PBR materials with subsurface scattering
