//
//  ViewsCoordinator.swift
//  SD-var.-1
//
//  Created by Алёша Виноградов on 16.06.2022.
//

import SwiftUI

struct ViewsCoordinator: View {
    
    @State var showMain = true

    var body: some View {
        if showMain{
            OnBoardView( showMain: $showMain)
                .onAppear {
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                        UINavigationController.attemptRotationToDeviceOrientation()
                    }
                    .onDisappear {
                        DispatchQueue.main.async {
                            AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                            UINavigationController.attemptRotationToDeviceOrientation()
                        }
                    }
            
        } else {
            ContentView()
                .onAppear {
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                        UINavigationController.attemptRotationToDeviceOrientation()
                    }
                    .onDisappear {
                        DispatchQueue.main.async {
                            AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                            UINavigationController.attemptRotationToDeviceOrientation()
                        }
                    }
        }
        
    }
    
    
}

struct ViewsCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        ViewsCoordinator()
    }
}
