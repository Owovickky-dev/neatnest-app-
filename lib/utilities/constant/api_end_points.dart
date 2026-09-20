class ApiEndPoints {
  static final baseUrl =
      "https://sevenfold-chance-giggle.ngrok-free.dev/api/v1";
  static final socketIo = "https://sevenfold-chance-giggle.ngrok-free.dev";
  static const login = "/auth/login";
  static const logout = "/auth/logout";
  static const aboutMe = "/auth/me";
  static const register = "/auth/register";
  static const refreshToken = "/auth/refreshtoken";
  static const ads = "/ads";
  static const getPopularAds = "/ads/popularads";
  static const favourite = "/favourite";
  static const getUserAds = "/ads/me";
  static const paymentMethod = "/payment-method";
  static const address = "/user-address";
  static const getCountries = "/address/countries";
  static const getState = "/address/states";
  static const updatePassword = "/user/updatepassword";
  static const updateEmail = "/user/updateemail";
  static const updatePhone = "/user/updatephonenumber";
  static const updateUserDetails = "/user/me";
  static const chatUrl = "/chats/";
  static const messageUrl = "/messages/";
  static const bookingUrl = "/booking";
  static const profilePics = "/user/profilepic";
  static const serviceCategories = "/user/service-categories";
  static const otpMailVerification = "/auth/verifymail";
  static const resendMailOtp = "/auth/resendotp";
  static const forgotPassword = "/auth/forgotpassword";
  static const passwordCodeVerification = "/auth/passwordcodeverification";
  static const resetPassword = "/auth/resetpassword";
  static const userVerification = "/verification";
  static const getUserVerification = "$userVerification/user";
  static const getUserNotifications = "/notification";
}
