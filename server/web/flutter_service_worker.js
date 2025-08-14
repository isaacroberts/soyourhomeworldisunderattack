'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "5e38c7c4ae77a7a812f9aa15e09a8e81",
"main.dart.js_98.part.js": "092c684fa869fd32abd2db4c66f02eb3",
"main.dart.js_66.part.js": "0a2aeb2179bcb2208dd977e6710eee79",
"main.dart.js_63.part.js": "9e99d4ed63efe2fb832d6f4941770ba0",
"main.dart.js_32.part.js": "8b02c9a4870f2f6788be895e55323920",
"main.dart.js_75.part.js": "cbea9f64d45efc912b9652e2cb79d922",
"main.dart.js_9.part.js": "06aab8479202a2a7044940ee5d1edf20",
"flutter_bootstrap.js": "0d37f240456d5332527ae4b4c7ad8f23",
"main.dart.js_61.part.js": "d83f1a5f02c3e9638ce180566e133945",
"main.dart.js_64.part.js": "282d9b11cd342ede0f78c33354bc90e1",
"main.dart.js_60.part.js": "d4b0261eabc7edf44ba7232377f3263f",
"main.dart.js_102.part.js": "d3a8bd009302d397b59136c8ecd0657b",
"main.dart.js_76.part.js": "0da1c9c19bca1c90d91ed8f56c3ee06f",
"main.dart.js_106.part.js": "d2a2ccdb1969e8cc206b057a417f7cce",
"main.dart.js_62.part.js": "d6eeade8ec5ce971e58d9bf0342d9d07",
"main.dart.js_68.part.js": "99d5c63dae827f97f7a9aa13f5efeba5",
"main.dart.js_83.part.js": "73d4defeb18aea36e0e601b422be8899",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "fa80e2e7b8f274cfbf8eea3f558b2617",
"main.dart.js_71.part.js": "26ad14cc923dd9e72705a2f60112a856",
"main.dart.js_41.part.js": "7d59ada052e6f661e9db727965fc5867",
"main.dart.js_50.part.js": "c8fd66fb93c281274208786600ad53dc",
"main.dart.js_40.part.js": "4bb28015444398484b063273b5bb0243",
"main.dart.js_113.part.js": "5bf0940aacc2157208bf922998802b0c",
"main.dart.js_30.part.js": "b0b53345f0c5bd588c0fad8f6dc57d2e",
"main.dart.js_51.part.js": "0c9af8b6510b14766d0f61228554d1a2",
"main.dart.js_28.part.js": "c50b191a4f354ed44ceaabdd3efb0a22",
"main.dart.js_29.part.js": "2b0d51e282d5db8288106a1afe635534",
"main.dart.js_7.part.js": "6d658eda85c1a17ca4f8bb16c31d7867",
"main.dart.js_91.part.js": "01bfe78207443c40b84467443f153485",
"main.dart.js_8.part.js": "e3ed8a272d98aca9c094a6ff1a661639",
"main.dart.js_25.part.js": "c1152cd3b6ef2312fea135b46074aa22",
"main.dart.js_103.part.js": "f1e9b20944cc890407ce7cce685cd2a1",
"main.dart.js_1.part.js": "ff9d399b52b060b90b04ac944e6052da",
"main.dart.js_3.part.js": "8e2225e8c8558cbc5c7e9c85f7c407ee",
"main.dart.js_34.part.js": "340a4a19668afa033d43684c72c07998",
"main.dart.js_22.part.js": "61bad74e303eae76378db309f980c378",
"main.dart.js_14.part.js": "d2c14d59f80bd35720117e0e5e004d13",
"main.dart.js_49.part.js": "fad90c1a858d7f6641c2ef620ab1d8b7",
"main.dart.js_20.part.js": "5da749f633fdfc17c831de16a8fbcda6",
"main.dart.js_105.part.js": "5f9b78a1b1bd5dae980eb3c830cf0a3d",
"main.dart.js_6.part.js": "36bafa8259e299fc76d062652a6a9636",
"main.dart.js_87.part.js": "300689a426fe4f8fa5b156cda3a278aa",
"main.dart.js_46.part.js": "71784f72a38f70a1cb0202d29237be19",
"main.dart.js_16.part.js": "63c1e7adac95e6579db4c4ed467459ef",
"main.dart.js_5.part.js": "e36d03f3520670f1c3bd03aabde4fb88",
"main.dart.js_57.part.js": "16c9067c9bfc907019f2297a74b1648c",
"main.dart.js_82.part.js": "8e0a2f65c6dd59261b5d42e7a080e51d",
"main.dart.js_17.part.js": "3d0fe44a91938dea41f9a94af97f572a",
"main.dart.js_36.part.js": "40ca624034bc6bfeeadc47c018cf25ab",
"main.dart.js_15.part.js": "ebb17b7a76ac9102609c748cc39033fe",
"main.dart.js_31.part.js": "2a5959d9f3c438a4138389ccc3a56f02",
"main.dart.js_21.part.js": "2654e4eb2aff2141961097ffea265088",
"main.dart.js_10.part.js": "5c7bb59aa1749cbb70acb3a84cf16455",
"main.dart.js_73.part.js": "b9ebfd730a4b03e94c41ae17b907b826",
"main.dart.js_93.part.js": "b8219933bc57c9247e4bf5a2b111cee0",
"main.dart.js_115.part.js": "bd46d8f45cb6d958dfed7d1d32674633",
"main.dart.js_54.part.js": "3d017bf759773a4b3cb35a90fa8ec458",
"main.dart.js_38.part.js": "0bdc4188961a1946aeecf023b7980902",
"main.dart.js_116.part.js": "02cba299246c6fe15c683c52eae4253f",
"main.dart.js_74.part.js": "474c16f27b617d47b88aa3c1230c99a6",
"main.dart.js_53.part.js": "3ade46dec618fb1a4c6dcfe5f6d46e50",
"main.dart.js_96.part.js": "1c0f65bfc996bff016587c4ac1d44fa9",
"main.dart.js_81.part.js": "578acb4c00db9c7209eb0cea4f5dc3da",
"main.dart.js_19.part.js": "81b17ab2b676627bb597b2d45680f7d9",
"main.dart.js_18.part.js": "c3e3c725802d616c19f36e06242fcf00",
"main.dart.js_84.part.js": "b0ffb767e86f7fa2096fc0da1cacaf6d",
"main.dart.js_42.part.js": "b9010768056cc614067ce5993d0197e3",
"main.dart.js_55.part.js": "9e96692a7b2a4ed712e4d078c860c292",
"main.dart.js_107.part.js": "71be0519ca19acab870a3c1228f99372",
"main.dart.js_44.part.js": "521ed5cae1bc36d97eed751ac419345c",
"main.dart.js_65.part.js": "c7617f6064233b54233b8445c3ce1179",
"main.dart.js_72.part.js": "0860db160202aaf6c06d146339fd4b65",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "33d15695677f4489146ec15b90e6be94",
"main.dart.js_85.part.js": "fdb6dac1adfe22699a46254296aba14f",
"main.dart.js_108.part.js": "9e97014a9296f044e89162e38ba7a9b1",
"main.dart.js_59.part.js": "a173af8ac67c7627db95570391893f25",
"main.dart.js_94.part.js": "eff5ee87888953b937afcbfb77bf56cb",
"main.dart.js_89.part.js": "46c8eb715ebf73594eb46e238fb64614",
"main.dart.js_70.part.js": "b2f2f9842d3c96a0618ad252866c123d",
"main.dart.js_33.part.js": "aa008a32e8f0effe08bb9e46cb5c8f34",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "4eb3592f817e92dc2cd0520354d0aac2",
"main.dart.js_24.part.js": "e90e8d350307a7d4fb6a6a54afdcf403",
"main.dart.js_48.part.js": "d10b551dedc857aaa8a73f6b3dfe1364",
"main.dart.js_92.part.js": "6914d4735e5d248d30e70d6cf197d189",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "373201dfd1d26f7b5fd894c3114158dc",
"main.dart.js_11.part.js": "c1233716acb56226e1527357dfbed5be",
"index.html": "2c5bb45b65a51a887d2f33b17bbfac0a",
"/": "2c5bb45b65a51a887d2f33b17bbfac0a",
"main.dart.js_4.part.js": "5d5a8818b6ec8440360683b849b4dde5",
"main.dart.js_97.part.js": "8183019676ced6337f5f49caa14acb72",
"main.dart.js_26.part.js": "2e1b9571cadb78cb5f9d796cd5de9d7f",
"main.dart.js_47.part.js": "4861c7ed7470c428185c1df995ca4a68",
"main.dart.js_37.part.js": "45addaa837597a148d89ad79109457f9",
"main.dart.js_27.part.js": "2cd067746b8de5974c81d82a754cde5f",
"main.dart.js_99.part.js": "9f8024931fad5da7a312eacbc91c9b9e",
"main.dart.js_13.part.js": "6367fa96fada418df37dd2d692a8cf62",
"main.dart.js_112.part.js": "c108338881f27fc9d87250bb5cc348d5",
"main.dart.js_43.part.js": "f0ffdeca7116524e29dffecc7bc3db88",
"main.dart.js_39.part.js": "7d77086e6e3d3d34f348c111e5d432de",
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
"main.dart.js_88.part.js": "876c5fa3fe9a4c0075751a353b2174c4",
"main.dart.js_23.part.js": "63d68d4f2382ee30d7d1cdb3e0f8b68b",
"main.dart.js_67.part.js": "889a80c152d4be3aad67644880513c5f",
"main.dart.js_111.part.js": "72d43f155577e1171f4c61ce729767a3",
"main.dart.js_114.part.js": "e4ebe44e14bb038f28eb8e08fea6c982",
"main.dart.js_69.part.js": "ba96d93123de10c3725d8c1341931cc5",
"main.dart.js_100.part.js": "129b9600b80a1136d42a62394e10f2cb",
"manifest.json": "f41a1bcf7dd669f69c5758ad491dac0c",
"main.dart.js_78.part.js": "f774041e23970d82a2216bedf488bc81",
"main.dart.js_90.part.js": "0ad857c7e41fd0ad631e8e4b617affce",
"main.dart.js_35.part.js": "9516d93047770b0bdafba8ede5dd6516",
"main.dart.js_52.part.js": "c9006c22eec0b03bb40f4721866df64b",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "2525151fa65f9b469de9c898e4d96d0a",
"main.dart.js_2.part.js": "8a6839c7ef869899996bfbb8b934a474",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "e6bdf98da628a1a6c6a4c1a89336a9e5",
"main.dart.js_56.part.js": "af9484d04066811bacd73a99a478ac96",
"main.dart.js_80.part.js": "6a21e3a11bdd8aae739772af9ac98a74",
"main.dart.js_86.part.js": "2deb701c340fcc0e37727abccf5d7b0b",
"main.dart.js_12.part.js": "79741eff3e257d8720cdf560e6de7785"};
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
