# lottie-performance-bug
A Test App to help investigate [an issue](https://github.com/airbnb/lottie-ios/issues/1105) with Lottie. 

To see a repro of the issue: 
1. clone the repo
2. open `lottie_performance_bug.xcworkspace` in xcode
3. Run the app on a simulator to make sure everything works  
4. To run profiler, the app should run on a real device:
  - Connect a developer-registered device 
  - Choose a team (Tap the Project -> General tab -> Team) where this devide is registered.
  - Run profiler (Product -> Profile)
  - Choose Core Animation
  - Click the record button. 
5. Start scrolling back and forth without lifting the finger to see Device Utilization and Frames Per Second when animation is playing.
6. Click Paush Animation and scroll some more
7. Click Remove Lottie and scroll some more
