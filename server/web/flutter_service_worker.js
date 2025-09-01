'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "520835a1579d656466811f4c02bfe07f",
"main.dart.js_98.part.js": "092c684fa869fd32abd2db4c66f02eb3",
"main.dart.js_66.part.js": "912eb4d697b9ed70b335d3f6ba21b5b2",
"main.dart.js_63.part.js": "458415493665fd7be594eef2c26bd54f",
"main.dart.js_32.part.js": "11b67975ac40ccaa0c9d3447e7066736",
"main.dart.js_75.part.js": "530b1faac1e40e0d7672ed3e66b5b068",
"main.dart.js_9.part.js": "9af152caec96aded40d546f3130f9a81",
"flutter_bootstrap.js": "289f6b6ed222c51a74a2c97cde19b6b3",
"main.dart.js_61.part.js": "ecf91db692eeb5de069d49ca1a4cb837",
"main.dart.js_64.part.js": "09cce36129413d169623880ab7d73774",
"main.dart.js_60.part.js": "4ac6dd32dda79f3e40cd19e6354698e8",
"main.dart.js_102.part.js": "d3a8bd009302d397b59136c8ecd0657b",
"main.dart.js_76.part.js": "bbb71b1af3b7076e560ba1d8922401c2",
"main.dart.js_106.part.js": "d2a2ccdb1969e8cc206b057a417f7cce",
"main.dart.js_62.part.js": "85e7e27575156b13597a4675bab0bb5c",
"main.dart.js_68.part.js": "980e02bf232f418d8d277cd2947aa214",
"main.dart.js_83.part.js": "361710ba47050515c91e75b532ad8026",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "ff41b58cf91d735d76fc47266db481a5",
"main.dart.js_71.part.js": "03b3816bbe5e465cb0d1a281c6674d8b",
"main.dart.js_41.part.js": "24f10cfe03d15852a384980a9d8006eb",
"main.dart.js_50.part.js": "56b9504ed0d623948b6aa27a6bfe731c",
"main.dart.js_40.part.js": "b342963e6cdc9b7bd150277d63d21912",
"main.dart.js_113.part.js": "5bf0940aacc2157208bf922998802b0c",
"main.dart.js_30.part.js": "ded1d51c224e3ce2fed3eb7a046c7d2c",
"main.dart.js_51.part.js": "f6ec00700d898f8bbcbde9759b04fc07",
"main.dart.js_28.part.js": "c8992c4b220010363c34aa4727c8ae9b",
"main.dart.js_29.part.js": "e1cadbbbd0e218781bc5bab59cb42ae3",
"main.dart.js_7.part.js": "92b54c4d245de5da61315272190e43a7",
"main.dart.js_91.part.js": "7b8211bf0c587a895adf8feaf8dddee7",
"main.dart.js_8.part.js": "96b3ce95f6145a483531cb3da9c85431",
"main.dart.js_25.part.js": "4a58874d75f916e99f655b0ae9c91575",
"main.dart.js_103.part.js": "f1e9b20944cc890407ce7cce685cd2a1",
"main.dart.js_1.part.js": "a991793c617d6af59f41ce3c3ba0637b",
"main.dart.js_3.part.js": "f23de1cafd35682daccfeb7cba91af0e",
"main.dart.js_34.part.js": "44544e1cfc47c884563786cb3b7cd62a",
"main.dart.js_22.part.js": "24df11f48b147198ced0611ea69b13a1",
"main.dart.js_14.part.js": "d82c94a3828d042d36d229f9cc0d855c",
"main.dart.js_49.part.js": "b1b8ac3827802bd51b8d5fb0de2b12f0",
"main.dart.js_20.part.js": "eace6372410eebb445097ecf688c4930",
"main.dart.js_105.part.js": "5f9b78a1b1bd5dae980eb3c830cf0a3d",
"main.dart.js_6.part.js": "98c75d7c62d143ea6233bdafb227d292",
"main.dart.js_87.part.js": "130d6e2af5e801c391de93844fe4434f",
"main.dart.js_46.part.js": "385ac1a4dbaa099bfd67c1e21ee08934",
"main.dart.js_16.part.js": "0f97ba2802c35d52ee39fec330447743",
"main.dart.js_5.part.js": "1cd9dd2119d93341c2c391d40056bb15",
"main.dart.js_57.part.js": "46b151f6ab811af97603784cd891b7eb",
"main.dart.js_82.part.js": "62e388eb1f16e5dcd2594f12ed117f64",
"main.dart.js_17.part.js": "55881daa05035ff744540756f818f650",
"main.dart.js_36.part.js": "0ae383ca029afcdc0c2358cf56819367",
"main.dart.js_15.part.js": "d5dcbe26586257baf01a90ac159d6aac",
"main.dart.js_31.part.js": "b44ae2585fd198bbb04be5d92a8a0d98",
"main.dart.js_21.part.js": "42112bbbf05d4b826966a25c7cba5b6a",
"main.dart.js_10.part.js": "c3b8eec801a77fd789a4ab163d8c11ce",
"main.dart.js_73.part.js": "764c6aa0f84215325a6d267ca3cfc5e4",
"main.dart.js_93.part.js": "f931dee386689260df0702b7fa823460",
"main.dart.js_115.part.js": "bd46d8f45cb6d958dfed7d1d32674633",
"main.dart.js_54.part.js": "3c747ae911a7b98b785dbc63df905c3b",
"main.dart.js_38.part.js": "bdf65853ad6c3a183458a3096a23cf6c",
"main.dart.js_116.part.js": "02cba299246c6fe15c683c52eae4253f",
"main.dart.js_74.part.js": "f2d359c5022124151a89f01624c72f6f",
"main.dart.js_53.part.js": "9ac75f30020c39635f0b2982e7712a3b",
"main.dart.js_96.part.js": "e42e719815d9bdfc5029464be86c4172",
"main.dart.js_81.part.js": "b4b1bf9067a3a9db929375dbbce1bff1",
"main.dart.js_19.part.js": "d42682a9711627ca7055c80f969f5023",
"main.dart.js_18.part.js": "e777ac2e351a0aa609b217c4488f25a9",
"main.dart.js_84.part.js": "6d140fc0adaa1ae6ea8123b0d550aa41",
"main.dart.js_42.part.js": "a807d0a5da05db20c8b7f376102cf2fd",
"main.dart.js_55.part.js": "ebe081f16b79c0fd09b115b8d5fcb49a",
"main.dart.js_107.part.js": "71be0519ca19acab870a3c1228f99372",
"main.dart.js_44.part.js": "fb3add621bdb9d6dd3ee4cbd663cf2b7",
"main.dart.js_65.part.js": "598a6061743efb726d996b5db451d853",
"main.dart.js_72.part.js": "3c53801eace42f0383da47062c13d292",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "b4cad97a9c2507dcb54f5d5170737ca2",
"main.dart.js_85.part.js": "a5c86df4d65e1974c7f61eb1e79c87b5",
"main.dart.js_108.part.js": "9e97014a9296f044e89162e38ba7a9b1",
"main.dart.js_59.part.js": "554d9749c7b6451683384206f322d74f",
"main.dart.js_94.part.js": "0243891e0e951f2fd4e5ea16da5b4f07",
"main.dart.js_89.part.js": "96218c2c44ecd7cba6dc996eaa8fd0ab",
"main.dart.js_70.part.js": "8f7583b5de1441a2bb3bd52a441cf629",
"main.dart.js_33.part.js": "a5498bb5342fc354ab82868f78d5d503",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "1f7341966694fe6fc398026f293ac1c3",
"main.dart.js_24.part.js": "e19f710a3e54db75cacda85b3c07e5ab",
"main.dart.js_48.part.js": "406c319c9b9c647c5c1b6d62df9c7f86",
"main.dart.js_92.part.js": "987eaf39378595a66d57bf81e2520e6d",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "373201dfd1d26f7b5fd894c3114158dc",
"main.dart.js_11.part.js": "8bfd65b573b3485330e75569e4b35122",
"index.html": "a38ab5765176f68cad05ee48662b864f",
"/": "a38ab5765176f68cad05ee48662b864f",
"main.dart.js_4.part.js": "9ac30f1070e91ae5cb63363cb4a93964",
"main.dart.js_97.part.js": "8183019676ced6337f5f49caa14acb72",
"main.dart.js_26.part.js": "b6b5f5dfcd8bd76107a4286fe32b7293",
"main.dart.js_47.part.js": "7db4a5948d0cfbfad2ae40ad7ab4f22e",
"main.dart.js_37.part.js": "5ab10d1f5fc7253d1ea4d76c7c5e96b2",
"main.dart.js_27.part.js": "4e317b173e5fbe0d87c9a462014d4cc1",
"main.dart.js_99.part.js": "9f8024931fad5da7a312eacbc91c9b9e",
"main.dart.js_13.part.js": "f5d79d03844652ff3cb785decc64fa1b",
"main.dart.js_112.part.js": "c108338881f27fc9d87250bb5cc348d5",
"main.dart.js_43.part.js": "e888dac077b6123af95377ddc2ff5e94",
"main.dart.js_39.part.js": "35c3417db439d67dc07c923c48a65a4a",
"assets/AssetManifest.bin": "cd5d7abf98054bdf8a9d1c8eb941fcd0",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "50204dc89005b799bf8b48ba16a1d3d7",
"assets/fonts/MaterialIcons-Regular.otf": "6d159077de259d94cfba0155cfb7505c",
"assets/FontManifest.json": "3002a5264f22544b5ff394355b0605d5",
"assets/AssetManifest.json": "845139c6a2d4e9245bbe46e978b2be42",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "9c1692f49e2646eac51f22def6eece56",
"main.dart.js_88.part.js": "775856a3e98efd6ad119b0f7ed2e5006",
"main.dart.js_23.part.js": "88e908211e036b8af516116a2b44e49c",
"main.dart.js_67.part.js": "fc37f76d63cec70d369e2ddc6ae1f9ab",
"main.dart.js_111.part.js": "72d43f155577e1171f4c61ce729767a3",
"main.dart.js_114.part.js": "e4ebe44e14bb038f28eb8e08fea6c982",
"main.dart.js_69.part.js": "7627424d578452b60b8f3183a036ea31",
"main.dart.js_100.part.js": "129b9600b80a1136d42a62394e10f2cb",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "34bd3c32e65ea79ae9cea10018c7fc85",
"main.dart.js_90.part.js": "c0f402ffea15c05c480861957a2cc2de",
"main.dart.js_35.part.js": "87a724b434d49b6ae1a494431009eb62",
"main.dart.js_52.part.js": "1c57f7f758140e5edc1e5b5f20c66445",
"main.dart.js_95.part.js": "16c0f51899c9124e316a328b66f7ccdc",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "2525151fa65f9b469de9c898e4d96d0a",
"main.dart.js_2.part.js": "002bc3ba4c1c92d3f0be760a19613899",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "3028e9fc19973c53244f6558a601ce20",
"main.dart.js_56.part.js": "9c15f58c0a0fff4759fdbc6ccf990699",
"main.dart.js_80.part.js": "300df18d5f4ac2da97ae650e9024f765",
"main.dart.js_86.part.js": "b943a11ece1b6d7107bdc08269e9ac44",
"main.dart.js_12.part.js": "faf3be7b6d73e7e3b26c004cf50f4759"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
