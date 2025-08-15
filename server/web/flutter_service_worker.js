'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "da9d8dbbcf03e3d4c167df494fb0316f",
"main.dart.js_98.part.js": "092c684fa869fd32abd2db4c66f02eb3",
"main.dart.js_66.part.js": "ebe0aed72d6b8dbf1bd4cbcb3ddf4511",
"main.dart.js_63.part.js": "9e99d4ed63efe2fb832d6f4941770ba0",
"main.dart.js_32.part.js": "2e78e4e9fd841d1dea62c07e19390c2f",
"main.dart.js_75.part.js": "72bead08c880ed98131188753fd3943e",
"main.dart.js_9.part.js": "ac8fa92b2d5f2cd572538b0d4f228c26",
"flutter_bootstrap.js": "4ad2eaeb9f17b5b80c2342de48b17947",
"main.dart.js_61.part.js": "6bc965c6ce903e44c3c51cddba42d24a",
"main.dart.js_64.part.js": "6aeb21425a8a1eb5c2e9211873086fe5",
"main.dart.js_60.part.js": "7202135fdec2ef1cd09a1cd03b1d3139",
"main.dart.js_102.part.js": "d3a8bd009302d397b59136c8ecd0657b",
"main.dart.js_76.part.js": "47de3d7dcd0a56ccda2dc8493c6b2acd",
"main.dart.js_106.part.js": "d2a2ccdb1969e8cc206b057a417f7cce",
"main.dart.js_62.part.js": "51a12268659ca245d4a33e19073a782a",
"main.dart.js_68.part.js": "657ef12316a2c0307f53b74780ccd592",
"main.dart.js_83.part.js": "bbce69f26a1411ad5edec7a438f3a012",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "3fb6b5786803e259c920cec8686b212a",
"main.dart.js_71.part.js": "7b460ed2999635e28c616ca782e8c09f",
"main.dart.js_41.part.js": "a1632034998ef4f5107ce44d651e7970",
"main.dart.js_50.part.js": "135ca5abc7156185b82da0f7ca4e68cd",
"main.dart.js_40.part.js": "0455047b6ac4a52a8fe776fc2e16e7e7",
"main.dart.js_113.part.js": "5bf0940aacc2157208bf922998802b0c",
"main.dart.js_30.part.js": "7a5cccd54039ba2f34b443a4165d8a20",
"main.dart.js_51.part.js": "0bdbac9ec3421446ad5504fc4d2c3567",
"main.dart.js_28.part.js": "c50b191a4f354ed44ceaabdd3efb0a22",
"main.dart.js_29.part.js": "ba0f607780b09ebeb8f869f0fc45da8f",
"main.dart.js_7.part.js": "48b9ebd05373d3b365ddfa93a4cd5ac0",
"main.dart.js_91.part.js": "a1abeff771ab8c2a7dfb90ea7fba7aa4",
"main.dart.js_8.part.js": "6d544b9088854e23d906d1e67f73c82d",
"main.dart.js_25.part.js": "5931f25aba6cb9d28086e4f28c89b2d6",
"main.dart.js_103.part.js": "f1e9b20944cc890407ce7cce685cd2a1",
"main.dart.js_1.part.js": "0a3a1bef9bfc751f2f9ed2ed8e0f7157",
"main.dart.js_3.part.js": "14e741a0f5612c9c334e740719017ad3",
"main.dart.js_34.part.js": "47893538ec59d9bba1f054dd092b00d0",
"main.dart.js_22.part.js": "24df11f48b147198ced0611ea69b13a1",
"main.dart.js_14.part.js": "aaa106c45bcd5dda0ec781c4b777f88a",
"main.dart.js_49.part.js": "ffe1dc7c6aa35ff7c7c153858ea1f8d4",
"main.dart.js_20.part.js": "5da749f633fdfc17c831de16a8fbcda6",
"main.dart.js_105.part.js": "5f9b78a1b1bd5dae980eb3c830cf0a3d",
"main.dart.js_6.part.js": "be70b808d22b6dd93ebf58b7ac3742ce",
"main.dart.js_87.part.js": "236d9d17f8ee778e1ac0c4452c5cb6f5",
"main.dart.js_46.part.js": "0a606b4cce796105c8101d459b441a6e",
"main.dart.js_16.part.js": "fc6b27fb888c0ddce6138ed908601119",
"main.dart.js_5.part.js": "bfeed0182ede4ebcf889115082ede5e2",
"main.dart.js_57.part.js": "634d20449ced4f3bf56d889715d28910",
"main.dart.js_82.part.js": "1af0536b0b73931235c44678b333d809",
"main.dart.js_17.part.js": "3d0fe44a91938dea41f9a94af97f572a",
"main.dart.js_36.part.js": "aa1741857ab6b76b3095c31f31ea0d19",
"main.dart.js_15.part.js": "ebb17b7a76ac9102609c748cc39033fe",
"main.dart.js_31.part.js": "e6aebf3eb7193e95a43cd3937f15c5bd",
"main.dart.js_21.part.js": "d3e5ccf55a8801c0cabada76b4b535b6",
"main.dart.js_10.part.js": "811dcf073484aa7cabb177cd0aa7e2b1",
"main.dart.js_73.part.js": "c9cc18ad9b247e0ec55c47f7e39479d1",
"main.dart.js_93.part.js": "ea78e827da3a5b138d1326f3e5db63aa",
"main.dart.js_115.part.js": "bd46d8f45cb6d958dfed7d1d32674633",
"main.dart.js_54.part.js": "69bed8d1c10d85af24a7ae925a9f355a",
"main.dart.js_38.part.js": "0bdc4188961a1946aeecf023b7980902",
"main.dart.js_116.part.js": "02cba299246c6fe15c683c52eae4253f",
"main.dart.js_74.part.js": "150f62d039b58d88e0bec28a3f3d3401",
"main.dart.js_53.part.js": "6008fa0225e56b9cd62aa88b16621237",
"main.dart.js_96.part.js": "1c0f65bfc996bff016587c4ac1d44fa9",
"main.dart.js_81.part.js": "1db9b44e2ffe3335221891460f6b2eff",
"main.dart.js_19.part.js": "ff794620260134dc1c302569570cae46",
"main.dart.js_18.part.js": "6c32bbd37719083af97f7c4303b608b5",
"main.dart.js_84.part.js": "0184ca49197e8f8a81db9d7a27306121",
"main.dart.js_42.part.js": "b9010768056cc614067ce5993d0197e3",
"main.dart.js_55.part.js": "f966b932996f3ec0dab922881b09190b",
"main.dart.js_107.part.js": "71be0519ca19acab870a3c1228f99372",
"main.dart.js_44.part.js": "df9c16354487daf411f3c78f600750d7",
"main.dart.js_65.part.js": "6a63566a0730c881a3155248b3076dd8",
"main.dart.js_72.part.js": "9a4b7320f8f55a60ca15df80fa2361f5",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "993b980ca1db01bef71fd9d45005249e",
"main.dart.js_85.part.js": "4d5a6d8ff64e9bc9743e01bda9c67cfb",
"main.dart.js_108.part.js": "9e97014a9296f044e89162e38ba7a9b1",
"main.dart.js_59.part.js": "c959dabf22c61b3a82307df504ef3446",
"main.dart.js_94.part.js": "eff5ee87888953b937afcbfb77bf56cb",
"main.dart.js_89.part.js": "2ed35174d96705bd838ae802c6905742",
"main.dart.js_70.part.js": "d5772394fcf53b06557596b073f57dc3",
"main.dart.js_33.part.js": "aa008a32e8f0effe08bb9e46cb5c8f34",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "3865c31dd3752e6658897207c52f7a7d",
"main.dart.js_24.part.js": "e90e8d350307a7d4fb6a6a54afdcf403",
"main.dart.js_48.part.js": "3a958a5a60596abb47c3cd6a690e9276",
"main.dart.js_92.part.js": "9388f80330a8595b2eaad1bbfc2eb179",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "373201dfd1d26f7b5fd894c3114158dc",
"main.dart.js_11.part.js": "f518e1891bccad22f8ad60bbf05a5763",
"index.html": "2c5bb45b65a51a887d2f33b17bbfac0a",
"/": "2c5bb45b65a51a887d2f33b17bbfac0a",
"main.dart.js_4.part.js": "04893c91382e645f1cf12274fb656e9e",
"main.dart.js_97.part.js": "8183019676ced6337f5f49caa14acb72",
"main.dart.js_26.part.js": "a5ce0036e71a29489189c52b2232b562",
"main.dart.js_47.part.js": "dfbad33fbdd7ead1dd5d93b8cfb56108",
"main.dart.js_37.part.js": "f168f81b7a793bd4000f2b292f6979e2",
"main.dart.js_27.part.js": "d65f666bb0d571a18d90f178e11458b0",
"main.dart.js_99.part.js": "9f8024931fad5da7a312eacbc91c9b9e",
"main.dart.js_13.part.js": "6367fa96fada418df37dd2d692a8cf62",
"main.dart.js_112.part.js": "c108338881f27fc9d87250bb5cc348d5",
"main.dart.js_43.part.js": "f05e29c1ee0e65b9da6f2ef791f984dd",
"main.dart.js_39.part.js": "9a9bf8734439656b4ecb9f07ddd882cb",
"assets/AssetManifest.bin": "cd5d7abf98054bdf8a9d1c8eb941fcd0",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "50204dc89005b799bf8b48ba16a1d3d7",
"assets/fonts/MaterialIcons-Regular.otf": "e8a888495894017772eef6730b7fcb69",
"assets/FontManifest.json": "3002a5264f22544b5ff394355b0605d5",
"assets/AssetManifest.json": "845139c6a2d4e9245bbe46e978b2be42",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "9c1692f49e2646eac51f22def6eece56",
"main.dart.js_88.part.js": "bd39ebd7735c129b7f6e16a81966558f",
"main.dart.js_23.part.js": "cf281fdaaa60bfa2685c3599c85eeb62",
"main.dart.js_67.part.js": "054c23d3919113d5dbfcbdf0aa0edc84",
"main.dart.js_111.part.js": "72d43f155577e1171f4c61ce729767a3",
"main.dart.js_114.part.js": "e4ebe44e14bb038f28eb8e08fea6c982",
"main.dart.js_69.part.js": "6f08bf1419729d41118bf9529a836f0a",
"main.dart.js_100.part.js": "129b9600b80a1136d42a62394e10f2cb",
"manifest.json": "f41a1bcf7dd669f69c5758ad491dac0c",
"main.dart.js_78.part.js": "13b4ea69cf61fc774ef7962c6b176432",
"main.dart.js_90.part.js": "137788da185586992f9ed4633a618879",
"main.dart.js_35.part.js": "107b46b76b391b1da7ddfb73819512d3",
"main.dart.js_52.part.js": "8eb028ff7e5a38fe1844057d734cc4d3",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "2525151fa65f9b469de9c898e4d96d0a",
"main.dart.js_2.part.js": "fd0f3949faeb55dae628ebfdce5a1600",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "e6bdf98da628a1a6c6a4c1a89336a9e5",
"main.dart.js_56.part.js": "c046e9de250f13c0a6bd9808e7008120",
"main.dart.js_80.part.js": "2a1917082977b88594a21546e9e86ad2",
"main.dart.js_86.part.js": "c327daff03ba5c043d73c1d3718a5cc4",
"main.dart.js_12.part.js": "59cd1c942717644bde275d6e4415d857"};
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
