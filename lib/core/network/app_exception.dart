/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/13/20, 8:49 PM
 */

class ApiException {
  String message;
  ApiException({this.message});
  @override
  String toString() {
    return message;
  }
}

class FatalException {
  String message;
  FatalException({this.message});
  @override
  String toString() {
    return message;
  }
}