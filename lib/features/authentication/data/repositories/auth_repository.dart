import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  String _emailFromPhone(String phone) {
    final normalizedPhone = phone.trim();
    return 'driver_$normalizedPhone@driver.wasselni.app';
  }

  Future<UserCredential> login({
    required String phone,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: _emailFromPhone(phone),
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw Exception('تعذر التحقق من حساب المندوب');
      }

      final driverDoc = await _firestore
          .collection('drivers')
          .doc(user.uid)
          .get();

      final data = driverDoc.data();

      if (!driverDoc.exists || data == null) {
        await _auth.signOut();
        throw Exception('حساب المندوب غير مسجل في النظام');
      }

      if (data['isApproved'] != true) {
        await _auth.signOut();
        throw Exception('حسابك لم تتم الموافقة عليه بعد');
      }

      if (data['isActive'] != true) {
        await _auth.signOut();
        throw Exception('حساب المندوب غير مفعل حاليًا');
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapAuthError(e.code));
    } on FirebaseException catch (e) {
      if (_auth.currentUser != null) {
        await _auth.signOut();
      }

      if (e.code == 'permission-denied') {
        throw Exception('لا تملك صلاحية التحقق من حساب المندوب');
      }

      throw Exception('تعذر الاتصال بالخدمة. حاول مرة أخرى');
    } catch (_) {
      if (_auth.currentUser != null) {
        await _auth.signOut();
      }
      rethrow;
    }
  }

  String _mapAuthError(String code) {
    switch (code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return 'رقم الهاتف أو كلمة المرور غير صحيحة';

      case 'invalid-email':
        return 'رقم الهاتف غير صحيح';

      case 'too-many-requests':
        return 'محاولات كثيرة. حاول مرة أخرى لاحقًا';

      case 'network-request-failed':
        return 'تحقق من اتصال الإنترنت';

      case 'user-disabled':
        return 'تم تعطيل هذا الحساب';

      default:
        return 'تعذر تسجيل الدخول. حاول مرة أخرى';
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
