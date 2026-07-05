// Firebase Configuration & Initialization
// Using Compat SDK (Global Namespace) for file:// protocol support

const firebaseConfig = {
  apiKey: "AIzaSyBu4dWZ0bxnCaSDm-ejSUJcHzriLS1J4z8",
  authDomain: "anwar-ali-fc367.firebaseapp.com",
  projectId: "anwar-ali-fc367",
  storageBucket: "anwar-ali-fc367.firebasestorage.app",
  messagingSenderId: "451153291382",
  appId: "1:451153291382:web:f087d2f9cd87fb26a4d757",
  measurementId: "G-6ZL4RGBZ2S"
};

// Initialize Firebase
if (typeof firebase !== 'undefined') {
  firebase.initializeApp(firebaseConfig);

  // Initialize Services safely
  // We use var/window to ensure global scope availability
  window.auth = firebase.auth();
  window.db = firebase.firestore();
  window.storage = firebase.storage();

  console.log("Firebase Initialized Correctly (Auth, Firestore, Storage)");
} else {
  console.error("Firebase SDK not loaded. Make sure script tags are correct.");
  alert("Critical Error: Firebase SDK not loaded. Please check internet connection.");
}
