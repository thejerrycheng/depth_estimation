# Vision-Based Depth Estimation for Human-Robot Locomotion

## Project Description
This project aims to develop a vision-based depth estimation system specifically designed for human-robot locomotion environments. The primary objective is to accurately estimate the depth of human walking environments using a monocular camera, optimized for embedded device applications.

### Objective
- Develop a depth estimation system for human-robot interaction environments using a monocular camera.

### Scope
- The project is confined to human-robot interaction scenarios, emphasizing efficient and precise depth estimation.

## Methodology
- **Depth Estimation:** Utilize a single RGB camera, incorporating the MiDaS algorithm for foundational depth estimation.
- **Ego Motion Estimation:** Implement ego motion estimation with a least square solution to extract and extrapolate depth from sparse feature points to a dense depth map.
- **Object Detection and Segmentation:** Use YOLO for advanced object detection and segmentation, with a focus on staircase detection for depth analysis.

## Expected Outcomes
- Process and analyze egocentric video footage, specifically focusing on staircases, to identify and extract features, and accurately estimate depth.
- Generate detailed depth maps of staircase areas within the footage.

## Challenges and State-of-the-Art Comparison
- The project aims to replace the current state-of-the-art depth estimation methods, which largely rely on time-of-flight sensors, with a camera-only solution. This approach intends to streamline the process and enhance applicability in diverse human-robot interaction environments.
