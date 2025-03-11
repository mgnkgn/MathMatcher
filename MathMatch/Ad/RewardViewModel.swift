//
//  RewardViewModel.swift
//  MathMatch
//
//  Created by Gunes Akgun on 30.09.2024.
//

import GoogleMobileAds


class RewardedViewModel: NSObject, ObservableObject, GADFullScreenContentDelegate {
	private var rewardedAd: GADRewardedAd?
	var gameManager: GameManager?
	
	func loadAd() async {
		do {
			rewardedAd = try await GADRewardedAd.load(
				//withAdUnitID: "ca-app-pub-6297830725022299~8070262052", request: GADRequest())
				withAdUnitID: "ca-app-pub-6297830725022299/8229672364", request: GADRequest())
			rewardedAd?.fullScreenContentDelegate = self
		} catch {
			DispatchQueue.main.async{
				self.gameManager?.showGameOver = true
			}
			print("Failed to load rewarded ad with error: \(error.localizedDescription)")
			
			
		
		}
	}
	
	func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
	  print("\(#function) called")
	}

	func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
	  print("\(#function) called")
	}

	func ad(
	  _ ad: GADFullScreenPresentingAd,
	  didFailToPresentFullScreenContentWithError error: Error
	) {
	  print("\(#function) called")
	}

	func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
	  print("\(#function) called")
	}

	func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
	  print("\(#function) called")
	}

	func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
	  print("\(#function) called")
	  // Clear the rewarded ad.
	  rewardedAd = nil
	}
	
	func showAd() {
	  guard let rewardedAd = rewardedAd else {
		return print("Ad wasn't ready.")
	  }

	  rewardedAd.present(fromRootViewController: nil) {
		
	  }
	}


}
