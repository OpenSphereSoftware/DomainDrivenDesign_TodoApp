

import 'package:dddcourse/domain/auth/user.dart';
import 'package:dddcourse/domain/core/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserDomainX on User {
  CustomUser toDomain(){
    return CustomUser(id:  UniqueId.fromUniqueString(uid),);
  }

} 