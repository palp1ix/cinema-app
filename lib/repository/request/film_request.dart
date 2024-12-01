import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:cinema/repository/models/film/film.dart';
import 'package:cinema/repository/models/session/session.dart';

class FilmRequest {
  FilmRequest({
    required this.dio,
  });
  final Dio dio;
  final endpoint = dotenv.get('ENDPOINT');

  Future<Film> getFilmById(int id) async {
    try {
      final response = await dio.get('$endpoint/api/films/$id');
      final data = response.data;
      final Film film = Film.fromJson(data);
      return film;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setFilm(Film film) async {
    try {
      final data = film.toJson();
      await dio.post('$endpoint/api/films', data: data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setRoom() async {
    try {
      await dio.post('$endpoint/api/rooms', data: {'seats': []});
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setSession(int filmId, int roomId) async {
    try {
      await dio.post('$endpoint/api/sessions', data: {
        'filmId': filmId,
        'roomId': roomId,
        'date': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Session>> getSessionsByOffset(int dayOffset) async {
    try {
      // await setNewFilmRoomSession();
      // await changeFilmParam();
      await Future.delayed(const Duration(seconds: 1));
      final response =
          await dio.get('$endpoint/api/sessions/current?daysOffset=$dayOffset');
      final data = response.data as List<dynamic>;
      final List<Session> sessions =
          data.map((e) => Session.fromJson(e)).toList();
      return sessions;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> changeFilmParam() async {
    await dio.patch('$endpoint/api/films/4', data: {
      'coverLink':
          'https://kinopoisk-ru.clstorage.net/t292eL390/be77f8JI/WQ076T-AL_K9LUSYP0KUulQXTNQlNEV7Ta_B0RQr8z3IESRoDM0PeCiV8Co3vT2w_d7xe8uK4RLhOEF0hnwj-d3JHn0P1dtTHbhheZvCsXoxFt20oDUUj8ibgAAhLhbPOxOnSpvvbIqqlzY-U1lMVTjLlX-rHxUXQJzlQ6Xdt_5pTvjIrtPNZrzdVL7t49Sa5UR5JPZHcSlt34VABkkjLehB1bk5bAw5C3WWjzCYCMc7eGXtuMznhrbcxAI2iQXNC7z6ms8BPZaOr4bdTDHm6ISlW1eFFpMbfR31sofIYY_IYtWaSUzO-xm2B8_TaggnWUj03ll_pRb0DzRCRqtnLOqMKtqN4Y2Vbo6lHHyB9ihHFZgUFZfx-9y89_E2SiEcqcKn2pkPbMhaN_bv4olopyjJBS05PzUWZiyGgvbpd98LvWno_8HP5Q-f9dyMccTadSeLtgWWg8ncjJQDhGtwrahAtAgbPw0YSETUfVGLmtQL-vdMWK9HFFffRAAmWTbtmD67euwwLkV_bGXdvhClWnSH6AQFtiNZ3wxnI5WKUK-YgMTZmM9cKou29I_ginsVKopkvfm_V1e233QDB7jk3ui-u8g-8Iz3TtyGPnwh13k1x2jklXUTK-2tJnO1mCN8SlMF6ljP33jIppWOs7lJh2lodu2JXcYUxxyXEGcZly75rVvaTNGPp119Nc28AmUa1wbaRvXlw8vdHLWTx8tRfqqC9NjIn99IqsTWf9L5qqUqeCXdK90Uh8Teh0NFe2WdCp5oWRywTbVO7kVd70BmSOSXynf3R8Mb_m7Xkee5wm-pQOZ4-42PSPqW1c9ymmvn6LgELevd1FZl7qTwhonGbMsOSygckg_23W-Hjj_B5VrGN7i0FVfSyGy_J2KkK4F_acPn-7ltb5j5Rte8Ups7tetqdLyaTZVHNj9UQqUaJ-4pzjr5LVPt1g_upx4_sYXaBwe5J-Xnctv_bNYDNfgxb_gjNjgJvb1pe3d1fVM4SjV6-Cb_Cv8XNWVtJFFUm8SO2hxIqpzRLmYfvCfuz4P3SCb2CCf2ZaNYDtzFoZfpk31r48b4y1_9G3n2td6jChjW2KoEjotOlIb3fXVSRumG35tMG0seg86X_G5FvPywVwg11goGlxei-C7-RVNX2bHd-DA16khdvQi7RRQOMWtLtLi4ZM3Kb6bltM5G4RU4x7xInvnKrMI8dr9d1p48QuV7V8XqdCelIQnejrfzV8mxHPhBh-uKDP1paNSGD5GrSfdreGfMin30lJZNhxB1SvTemUzoyp8DvVfMfKUODKMH2JdFqPTkFpDKbO4FEpWJg3x5YYV5Km_PiWhXt_0SCRumuErUnnrO9yS2jSZQdwqVv8ueSZje0hx2nu-1Ln6h5GsG9Vp0VFVx-e7Ml2OUiyE-qYF2GzlcDIorR1VN8YloFPqLJt57DsZlpqykAMUY5mwqPLnKbwJMFN_fd0184qXYJwaodJcGktpt7feSN6kCzeoTp3iYzs84WjYkn2FISkbICuaOG42mtSVtp4C3uRWM2F46-h6T_DdergW8XmI0KzYG2BQ0RHOrfa7noVbpgkxqEyRJGv6va7nVtbyDaJnH6TjW_huMxaRUz4cARRnHL7g8Krr8kl6nzz-Hv51SRphEdPmWVYcRmr98tTDFibPdWsDl6Zldb4sZhfQcM7p6xgtJJ15rXCUVJVzGoqdZBl5Kb8rpTSCst89N1K1coaSql9Z7dlXXIKoP3HVCtshSjlrzhUgpH_65GYXG76FpeYaby0adir_GFlQ9FlLlKJadqF9oqj3hjITNLicOvBEnSNS0CCVXRXArjX5GE5fIU31bkpU5Kr1vSBpVdo9BS1qlW3uVDhpu9pVknTdSxwqWHFnvClsNo87UDa83j17xlwpnx-pWt3QCiyy8p3AkqyEO-hP0ybk831iZZQffcNk7JVrp5g54z6R15D6nk1Raloy7z3raDXNu9x69pb5fUlVZRDS6BBUFwbpO7SXxdukAjLpgxdp6vh6KKLTmLjM6i_cI6yXO-I01F7QvZqCUWyasep7IW39Qj2SM7_avf5PXauVWmiWn98OabFzXsgQKUG74ovTbGm48ClmmlU-C6pin-SlV7cnfZYVmrYUidPjWPYnu-Ir8049XDs_nXl-QRSoFJmrEJZYQ-X0O5SA3KnO9m4OX2RhPrUh4ZvVPQktoFbpr55-67UQ3hu5VMQTJ1q3KTKvoPyPfVrx_lewPUsaohVfrFrYncosOrffClusArHuihHr4Lr-ZaddmbZILmeX46kUsSk-k9Wd_ZjE266fe2Dw6m_zDPkR9baQv_ZGkiEamCJa3tEAYX92WALXZYW-bQBUq-1wfSwpFxP-Q6NkXyXjWH4r_VLTVLqTABtj0TFhvKItf8_zmrYwnjHyB1cj0VlmmdsXjyYx-NaNlumFMOMDFmyrsD8kqxsfOgljq5utJp6_an6bWVB8EAETZ9ywr3Ml4L9EfxqzvZ969QxbJFQRpBBZlw-ptbLaSxHlxTWthRYrJLQ17GKaVz_D6ueW666T_CS8GdQQPFbEnqfZvCVwriR0hnvT-rXfMjCCUCNcV67XWZ6Hp3W3HM9faM16JYrRbGY19eHjUB_-hKOnXSfr1nfisBhcXH7ShNKnWTiuN-aqdYbxVzF4WvH_wxolHB_t09gexO-1sxVI2eiCvaPM2CotfXOr59ZYPAIoaJNjIZLy63VQHBgy0cWRLRB-b3pj47uMc5w-P18_vgAaKhhZpduZWcWpfrrWxRJgRbZgiNgrK_K4oeiY13BNbSMeYKEVtmr8mpJbtNzF0mxR-yD1oeO6zbCaPXzdP_DBUGDfEG0SXVRP4XYxGIMc5YFxL8rcZqH08KAjUlU1yy3ilqRlHTBjMx0VFbtagtggUrMvsCSr_oI_kTm_3HsyxJHh01ohUJeRBCa9NJDFWWVEeqFElqooujyu6hpTPgVpaFXlZVc55nyZVBB204'
    });
  }

  Future<void> setNewFilmRoomSession() async {
    await setFilm(Film(
        title: 'Марсианин',
        releaseDate: DateTime.now().toIso8601String(),
        genre: 'Фантастика',
        rating: 10,
        cast: '',
        duration: '2 ч 24 мин',
        trailerYoutubeLink: 'https://youtu.be/ej3ioOneTy8',
        coverLink:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/1900788/6f631486-e947-487d-94d6-41c2b5a8f5a0/600x900'));
    await setRoom();
    await setSession(4, 4);
  }
}
