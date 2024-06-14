import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:memorial_book/models/communitites/request/edit_community_request_model.dart';
import '../helpers/constants.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import '../models/catalog/request/edit_post_request_model.dart';

class APIManager {
  Future getRequest(
      String endpoint,
      Map<String, String>? headers,
      ValueSetter<Response?> completion,
      ) async {
    try{
      final Uri requestURL = Uri.parse(ConstantsUrls.baseUrl + endpoint);

      final Response response = await get(
        requestURL,
        headers: headers,
      );

      print(requestURL);
      print('---${response.body}');

      switch (response.statusCode) {
        case 200:
          completion(response);
          break;
        case 204:
          completion(response);
          break;
        case 401:
          completion(response);
          break;
        case 404:
          completion(response);
          break;
        case 500:
          completion(response);
          break;
        case 422:
          completion(response);
          break;
        default:
          completion(null);
          break;
      }
    } catch(error) {
      SVProgressHUD.dismiss();
    }

  }

  Future getPlaceRequest(
      Map<String, String>? headers,
      Map<String, String> params,
      ValueSetter<Response?> completion,
      ) async {
    String encodedBody = params.keys.map((key) => "$key=${params[key]}").join('&');
    final Uri requestURL = Uri.parse(ConstantsUrls.mapsUrl + encodedBody);

    final Response response = await get(
      requestURL,
      headers: headers,
    );

    print(requestURL);

    switch (response.statusCode) {
      case 200:
        completion(response);
        break;
      case 204:
        completion(response);
        break;
      case 401:
        completion(response);
        break;
      case 404:
        completion(response);
        break;
      case 500:
        completion(response);
        break;
      case 422:
        completion(response);
        break;
      default:
        completion(null);
        break;
    }
  }

  Future getRequestEncodedBody(
      String endpoint,
      Map<String, dynamic> body,
      Map<String, String>? headers,
      ValueSetter<Response?> completion,
      ) async {
    String encodedBody = body.keys.map((key) => "$key=${body[key]}").join('&');
    final Uri requestURL = Uri.parse('${ConstantsUrls.baseUrl}$endpoint?$encodedBody');

    final Response response = await get(
      requestURL,
      headers: headers,
    );
    print(requestURL);

    switch (response.statusCode) {
      case 200:
        completion(response);
        break;
        case 204:completion(response);
        break;
        case 401:completion(response);
        break;
        case 404:completion(response);
        break;
        case 500:completion(response);
        break;
        case 422:completion(response);
        break;
        default:completion(null);
        break;
    }
  }

  void getRequestWithQuery(
      String endpoint,
      Map<String, String>? headers,
      Map<String, String> qParams,
      ValueSetter<Response?> completion,
      ) async {
    final Uri requestURL = Uri.parse(
      ConstantsUrls.baseUrl + endpoint,
    );

    final finalRequestURL = requestURL.replace(
      queryParameters: qParams,
    );

    final Response response = await get(
      finalRequestURL,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        completion(response);
        break;
      case 204:
        completion(response);
        break;
      case 401:
        completion(response);
        break;
      case 404:
        completion(response);
        break;
      case 500:
        completion(response);
        break;
      case 422:
        completion(response);
        break;
      default:
        completion(null);
        break;
    }
  }

  void putRequest(
      String endpoint,
      Map<String, String>? headers,
      ValueSetter<Response?> completion,
      ) async {
    final Uri requestURL = Uri.parse(ConstantsUrls.baseUrl + endpoint);

    final Response response = await put(
      requestURL,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        completion(response);
        break;
      case 204:
        completion(response);
        break;
      case 401:
        completion(response);
        break;
      case 404:
        completion(response);
        break;
      case 422:
        completion(response);
        break;
      case 500:
        completion(response);
        break;
      default:
        completion(null);
        break;
    }
  }

  void putRequestWithBody(
      String endpoint,
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      ValueSetter<Response?> completion,
      ) async {
    final Uri requestURL = Uri.parse(ConstantsUrls.baseUrl + endpoint);

    final Response response = await put(
      requestURL,
      headers: headers,
      body: jsonEncode(body),
    );

    switch (response.statusCode) {
      case 200:
        completion(response);
        break;
      case 204:
        completion(response);
        break;
      case 401:
        completion(response);
        break;
      case 404:
        completion(response);
        break;
      case 500:
        completion(response);
        break;
      case 422:
        completion(response);
        break;
      default:
        completion(null);
        break;
    }
  }

  void postRequestWithBody(
      String startPoint,
      String endpoint,
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      ValueSetter<Response?> completion,
      ) async {
    final Uri requestURL = Uri.parse(startPoint + endpoint);

    final Response response = await post(
      requestURL,
      headers: headers,
      body: jsonEncode(body),
    );

    switch (response.statusCode) {
      case 200:
        completion(response);
        break;
      case 201:
        completion(response);
        break;
      case 204:
        completion(response);
        break;
      case 401:
        completion(response);
        break;
      case 404:
        completion(response);
        break;
      case 500:
        completion(response);
        break;
      case 422:
        completion(response);
        break;
      default:
        completion(null);
        break;
    }
  }

  Future postRequest(
      String endpoint,
      Map<String, String>? headers,
      ValueSetter<Response?> completion,
      ) async {
    final Uri requestURL = Uri.parse(ConstantsUrls.baseUrl + endpoint);

    final Response response = await post(
      requestURL,
      headers: headers,
    );

    print(requestURL);
    print(response.body);

    switch (response.statusCode) {
      case 200:
        completion(response);
        break;
      case 201:
        completion(response);
        break;
      case 204:
        completion(response);
        break;
      case 401:
        completion(response);
        break;
      case 404:
        completion(response);
        break;
      case 500:
        completion(response);
        break;
      case 422:
        completion(response);
        break;
      default:
        completion(null);
        break;
    }
  }

  void putRequestWithBodyTest(
      String endpoint,
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      ValueSetter<Response?> completion,
      ) async {
    String encodedBody = body!.keys.map((key) => "$key=${body[key]}",).join('&');

    final Uri requestURL = Uri.parse(ConstantsUrls.baseUrl + endpoint + '?' + encodedBody);

    final Response response = await put(
      requestURL,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        completion(response);
        break;
      case 204:
        completion(response);
        break;
      case 401:
        completion(response);
        break;
      case 404:
        completion(response);
        break;
      case 500:
        completion(response);
        break;
      case 422:
        completion(response);
        break;
      default:
        completion(null);
        break;
    }
  }

  void multiPartRequest(
      File? file,
      String endpoint,
      Map<String, String> body,
      Map<String, String> headers,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    try{
      final Uri requestURL = Uri.parse(ConstantsUrls.baseUrl + endpoint);
      print(requestURL);
      print(body);
      final MultipartRequest request = MultipartRequest('POST', requestURL);
      if(file != null) {
        MultipartFile multipartFile = await MultipartFile.fromPath(
          'avatar',
          File(file.path).path,
        );
        request.files.add(multipartFile);
      }
      request.headers.addAll(headers);
      request.fields.addAll(body);

      StreamedResponse response = await request.send();

      switch (response.statusCode) {
        case 200:
          completion(response);
          break;
        case 201:
          completion(response);
          break;
        case 204:
          completion(response);
          break;
        case 401:
          completion(response);
          break;
        case 404:
          completion(response);
          break;
        case 500:
          completion(response);
          break;
        case 422:
          completion(response);
          break;
        default:
          completion(null);
          break;
      }
    } catch(error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  Future deleteRequest(
      String endpoint,
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      ValueSetter<Response?> completion,
      ) async {
    final Uri requestURL = Uri.parse(ConstantsUrls.baseUrl + endpoint);

    final Response response = await delete(
      requestURL,
      headers: headers,
      body: jsonEncode(body),
    );

    print(response.body);

    switch (response.statusCode) {
      case 200:
        completion(response);
        break;
      case 204:
        completion(response);
        break;
      case 401:
        completion(response);
        break;
      case 404:
        completion(response);
        break;
      case 422:
        completion(response);
        break;
      case 500:
        completion(response);
        break;
      default:
        completion(null);
        break;
    }
  }

  Future multiPartRequestForProfile(
      File? avatar,
      File? banner,
      File? deathCertificate,
      List<File>? gallery,
      List<String>? hobbies,
      List<String>? mediaRemovedIds,
      String endpoint,
      Map<String, String> body,
      Map<String, String> headers,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    List<MultipartFile> galleryList = [];

    try {
      final Uri requestURL = Uri.parse(ConstantsUrls.baseUrl + endpoint);
      final MultipartRequest request = MultipartRequest('POST', requestURL);

      if(avatar != null) {
        MultipartFile avatarFile = await MultipartFile.fromPath(
          'avatar',
          File(avatar.path).path,
          filename: avatar.path
              .split('/')
              .last,
        );
        request.files.add(avatarFile);
      }
      
      if(banner != null) {
        MultipartFile bannerFile = await MultipartFile.fromPath(
          'banner',
          File(banner.path).path,
          filename: banner.path
              .split('/')
              .last,
        );
        request.files.add(bannerFile);
      }
      
      if(gallery != null && gallery.isNotEmpty) {
        for (File file in gallery) {
          if (file.path.isNotEmpty) {
            MultipartFile multipartFile = await MultipartFile.fromPath(
              'gallery[]',
              File(file.path).path,
              filename: file.path
                  .split('/')
                  .last,
            );
            galleryList.add(multipartFile);
          }
        }
      }
      if(deathCertificate != null) {
        MultipartFile deathCertificateFile = await MultipartFile.fromPath(
          'death_certificate',
          File(deathCertificate.path).path,
          filename: deathCertificate.path
              .split('/')
              .last,
        );
        request.files.add(deathCertificateFile);
      }
      if(hobbies != null && hobbies.isNotEmpty) {
        for (String item in hobbies) {
          request.files.add(
            MultipartFile.fromString(
              'hobbies[]',
              item,
            ),
          );
        }
      }
      if(mediaRemovedIds != null) {
        for (String item in mediaRemovedIds) {
          request.files.add(
            MultipartFile.fromString(
              'media_removed_ids[]',
              item,
            ),
          );
        }
      }
      request.headers.addAll(headers);
      request.fields.addAll(body);
      request.files.addAll(galleryList);

      StreamedResponse response = await request.send();

      print(response.statusCode);
      print(request.url);

      switch (response.statusCode) {
        case 200:
          completion(response);
          break;
        case 201:
          completion(response);
          break;
        case 204:
          completion(response);
          break;
        case 401:
          completion(response);
          break;
        case 404:
          completion(response);
          break;
        case 405:
          completion(response);
          break;
        case 500:
          completion(response);
          break;
        case 422:
          completion(response);
          break;
        default:
          completion(null);
          break;
      }
    } catch (error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  void multiPartRequestForCreatePost(
      String endpoint,
      List postMedia,
      Map<String, String> body,
      Map<String, String> headers,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    try {
      final Uri requestURL = Uri.parse(ConstantsUrls.baseUrl + endpoint);
      final MultipartRequest request = MultipartRequest('POST', requestURL);

      if(postMedia.isNotEmpty) {
        for (File file in postMedia) {
          MultipartFile multipartFile = await MultipartFile.fromPath(
            'gallery[]',
            File(file.path).path,
            filename: file.path
                .split('/')
                .last,
          );
          request.files.add(multipartFile);
        }
      }

      request.headers.addAll(headers);
      request.fields.addAll(body);

      StreamedResponse response = await request.send();

      print(response.statusCode);
      print(requestURL);

      switch (response.statusCode) {
        case 200:
          completion(response);
          break;
        case 201:
          completion(response);
          break;
        case 204:
          completion(response);
          break;
        case 401:
          completion(response);
          break;
        case 404:
          completion(response);
          break;
        case 405:
          completion(response);
          break;
        case 500:
          completion(response);
          break;
        case 422:
          completion(response);
          break;
        default:
          completion(null);
          break;
      }
    } catch (error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  void multiPartRequestForEditPost(
      EditPostRequestModel model,
      String endpoint,
      Map<String, String> body,
      Map<String, String> headers,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    try {
      final Uri requestURL = Uri.parse(ConstantsUrls.baseUrl + endpoint);
      final MultipartRequest request = MultipartRequest('POST', requestURL);


      if(model.postMedia != null && model.postMedia!.isNotEmpty) {
        for(var item in model.postMedia!) {
          if(item.runtimeType.toString() != '_Map<String, dynamic>') {
            MultipartFile multipartFile = await MultipartFile.fromPath(
              'gallery[]',
              File(item.path).path,
              filename: item.path
                  .split('/')
                  .last,
            );
            request.files.add(multipartFile);
          }
        }
      }
      if(model.postMedia != null && model.postMediaRemovedIds!.isNotEmpty) {
        for(String item in model.postMediaRemovedIds!) {
          if(item.runtimeType.toString() != '_Map<String, dynamic>') {
            MultipartFile multipartFile = MultipartFile.fromString(
              'gallery_removed_ids[]',
              item,
            );
            request.files.add(multipartFile);
          }
        }
      }

      request.headers.addAll(headers);
      request.fields.addAll(body);

      print(request.files);

      StreamedResponse response = await request.send();

      switch (response.statusCode) {
        case 200:
          completion(response);
          break;
        case 201:
          completion(response);
          break;
        case 204:
          completion(response);
          break;
        case 401:
          completion(response);
          break;
        case 404:
          completion(response);
          break;
        case 405:
          completion(response);
          break;
        case 500:
          completion(response);
          break;
        case 422:
          completion(response);
          break;
        default:
          completion(null);
          break;
      }
    } catch (error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }

  void multiPartRequestForEditCommunity(
      EditCommunityRequestModel model,
      String endpoint,
      Map<String, String> body,
      Map<String, String> headers,
      ValueSetter<StreamedResponse?> completion,
      ) async {
    try {
      final Uri requestURL = Uri.parse(ConstantsUrls.baseUrl + endpoint);
      final MultipartRequest request = MultipartRequest('POST', requestURL);

      print(body);

      if(model.avatar != null) {
        MultipartFile avatarFile = await MultipartFile.fromPath(
          'avatar',
          File(model.avatar!.path).path,
          filename: model.avatar!.path
              .split('/')
              .last,
        );
        request.files.add(avatarFile);
      }
      if(model.banner != null) {
        MultipartFile bannerFile = await MultipartFile.fromPath(
          'banner',
          File(model.banner!.path).path,
          filename: model.banner!.path
              .split('/')
              .last,
        );
        request.files.add(bannerFile);
      }
      if(model.gallery != null && model.gallery!.isNotEmpty) {
        for(var item in model.gallery!) {
          if(item.runtimeType.toString() != 'String') {
            MultipartFile multipartFile = await MultipartFile.fromPath(
              'gallery[]',
              File(item.path).path,
              filename: item.path
                  .split('/')
                  .last,
            );
            request.files.add(multipartFile);
          }
        }
      }
      if(model.mediaRemovedIds != null && model.mediaRemovedIds!.isNotEmpty) {
        for(String item in model.mediaRemovedIds!) {
          if(item.runtimeType.toString() == 'String') {
            MultipartFile multipartFile = MultipartFile.fromString(
              'media_removed_ids[]',
              item,
            );
            request.files.add(multipartFile);
          }
        }
      }

      request.headers.addAll(headers);
      request.fields.addAll(body);

      StreamedResponse response = await request.send();

      switch (response.statusCode) {
        case 200:
          completion(response);
          break;
        case 201:
          completion(response);
          break;
        case 204:
          completion(response);
          break;
        case 401:
          completion(response);
          break;
        case 404:
          completion(response);
          break;
        case 405:
          completion(response);
          break;
        case 500:
          completion(response);
          break;
        case 422:
          completion(response);
          break;
        default:
          completion(null);
          break;
      }
    } catch (error) {
      SVProgressHUD.dismiss();
      print('$error');
    }
  }
}
