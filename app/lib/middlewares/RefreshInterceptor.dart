import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../controllers/user_bloc.dart';
import '../models/user.dart';


/// Implementação de interceptor pattern nas requisições
/// da aplicação, ao detectar um token expirado faz a requisição
/// automática de renovação de token

class RefreshInterceptor implements InterceptorContract{

    DateTime refreshDate;

    RefreshInterceptor(this.refreshDate);

    @override
    Future<RequestData> interceptRequest({RequestData data}) async {
      if (DateTime.now().isAfter(this.refreshDate)) {
        await BlocProvider.getBloc<UserBloc>().refresh();
        User socio = await (BlocProvider.getBloc<UserBloc>().getUser).first;
        data.headers["Authorization"] = "Bearer ${socio.token.accessToken}"; 
      }

      return data;
    }

    @override
    Future<ResponseData> interceptResponse({ResponseData data}) async => data;
}