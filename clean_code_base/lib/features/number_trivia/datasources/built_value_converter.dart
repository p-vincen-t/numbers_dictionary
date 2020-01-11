/*
 * Copyright 2020 Peter Vincent
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'serializers.dart';

class BuiltValueConverter extends JsonConverter {
  @override
  Request convertRequest(Request request) => super.convertRequest(
        request.replace(
          body: serializers.serializeWith(
            serializers.serializerForType(request.body.runtimeType),
            request.body,
          ),
        ),
      );

  @override
  Response<BodyType> convertResponse<BodyType, SingleItemType>(
      Response response) {
    final Response dynamicResponse = super.convertResponse(response);
    final BodyType customBody = _convertToCustomObject<SingleItemType>(
      dynamicResponse.body,
    );
    return dynamicResponse.replace<BodyType>(
      body: customBody,
    );
  }

  dynamic _convertToCustomObject<SingleItemType>(
    dynamic element,
  ) {
    if (element is SingleItemType) {
      return element;
    }
    if (element is List) {
      return _deserializeListOf<SingleItemType>(
        element,
      );
    } else {
      return _deserialize<SingleItemType>(
        element,
      );
    }
  }

  BuiltList<SingleItemType> _deserializeListOf<SingleItemType>(
    List element,
  ) {
    return BuiltList<SingleItemType>(
      element.map(
        (e) => _deserialize<SingleItemType>(
          e,
        ),
      ),
    );
  }

  SingleItemType _deserialize<SingleItemType>(
    Map<String, dynamic> element,
  ) {
    return serializers.deserializeWith(
      serializers.serializerForType(
        SingleItemType,
      ),
      element,
    );
  }
}
