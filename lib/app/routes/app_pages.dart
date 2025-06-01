import 'package:get/get.dart';

import '../modules/Account/bindings/account_binding.dart';
import '../modules/Account/views/account_view.dart';
import '../modules/AddAddress/bindings/add_address_binding.dart';
import '../modules/AddAddress/views/add_address_view.dart';
import '../modules/Checkout/bindings/checkout_binding.dart';
import '../modules/Checkout/views/checkout_view.dart';
import '../modules/HomePage/bindings/home_page_binding.dart';
import '../modules/HomePage/views/home_page_view.dart';
import '../modules/detail_roti/bindings/detail_roti_binding.dart';
import '../modules/detail_roti/views/detail_roti_view.dart';
import '../modules/edit_roti/bindings/edit_roti_binding.dart';
import '../modules/edit_roti/views/edit_roti_view.dart';
import '../modules/keranjang/bindings/keranjang_binding.dart';
import '../modules/keranjang/views/keranjang_view.dart';
import '../modules/landing_page/bindings/landing_page_binding.dart';
import '../modules/landing_page/views/landing_page_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/lupa_password/bindings/lupa_password_binding.dart';
import '../modules/lupa_password/views/lupa_password_view.dart';
import '../modules/payment_method_dropdown/bindings/payment_method_dropdown_binding.dart';
import '../modules/payment_method_dropdown/views/payment_method_dropdown_view.dart';
import '../modules/register_page/bindings/register_page_binding.dart';
import '../modules/register_page/views/register_page_view.dart';
import '../modules/tambah_roti/bindings/tambah_roti_binding.dart';
import '../modules/tambah_roti/views/tambah_roti_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING_PAGE;

  static final routes = [
    GetPage(
      name: Routes.LANDING_PAGE,
      page: () => LandingPage(),
      binding: LandingPageBinding(),
    ),
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_PAGE,
      page: () => RegisterPageView(),
      binding: RegisterPageBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_PASSWORD,
      page: () => LupaPasswordView(),
      binding: LupaPasswordBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_ROTI,
      page: () => const TambahRotiView(),
      binding: TambahRotiBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ROTI,
      page: () => const EditRotiView(),
      binding: EditRotiBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ROTI,
      page: () => const DetailRotiView(),
      binding: DetailRotiBinding(),
    ),
    GetPage(
      name: _Paths.KERANJANG,
      page: () => KeranjangView(),
      binding: KeranjangBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ADDRESS,
      page: () => AddAddressView(),
      binding: AddAddressBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHOD_DROPDOWN,
      page: () => PaymentMethodDropdown(),
      binding: PaymentMethodDropdownBinding(),
    ),
  ];
}
