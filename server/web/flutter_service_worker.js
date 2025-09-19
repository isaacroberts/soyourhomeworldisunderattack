'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "c9b60546607e9a7a67011d906a162e11",
"main.dart.js_98.part.js": "e0e2a96bf92dd5b35632db4c4fabc85f",
"main.dart.js_66.part.js": "379e1915310a6987e4c8432b19d58ec0",
"main.dart.js_63.part.js": "62cd85aab6849b56337897eca7f84672",
"main.dart.js_32.part.js": "df6d6f39cd1f82dc0a530fb295d7fb91",
"main.dart.js_75.part.js": "d1a0044fc39be3b3842d2c174c6ef118",
"main.dart.js_9.part.js": "21cf22c2ea347dce5154f2b8d17dfd95",
"flutter_bootstrap.js": "0dbe17e1b8cf33b71731e4113a814d4e",
"main.dart.js_61.part.js": "fbc8be32a83af22e733e2c734cda7715",
"main.dart.js_64.part.js": "790bdd03d77d16972102632cc9acb418",
"main.dart.js_60.part.js": "51b7657ddb37411433859ac337f7ee5d",
"main.dart.js_102.part.js": "aeb11ee479b482fafcf513f623257524",
"main.dart.js_76.part.js": "20e174fb89332856c7337bba128e19b4",
"main.dart.js_106.part.js": "b211ec063305052492504663c2f5b0da",
"main.dart.js_62.part.js": "0dfb98b8ca32cd99fdd11c96219c0809",
"main.dart.js_68.part.js": "ae1d5394dfdbbe544926ecf986ad6694",
"main.dart.js_83.part.js": "5f67521a6376b30acfe107ec4ab3c270",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "52af886ace1d3f129d1bcaf03736fc70",
"main.dart.js_71.part.js": "91fdeea712cd58094f6bb143cfa9e3b9",
"main.dart.js_41.part.js": "6e83cba65784da1a401cb58b56ff0b5c",
"main.dart.js_50.part.js": "cf4f90b3cbbb7199b59b595527558bf9",
"main.dart.js_40.part.js": "d3389678aaac961319f9e78330d0297c",
"main.dart.js_113.part.js": "5bf0940aacc2157208bf922998802b0c",
"main.dart.js_101.part.js": "51075789643174e33919418727a114a1",
"main.dart.js_30.part.js": "9b96e4edca217593ef71f38de04a0c5c",
"main.dart.js_51.part.js": "37af3aefbba4f03191bf28b984941b27",
"main.dart.js_28.part.js": "7c908c0e529c6fc3eeff58c3f003682a",
"main.dart.js_29.part.js": "906db31167cbe3d994900cd7d6330c4e",
"main.dart.js_7.part.js": "ce14b08c86e9b4e273123c7ccff5d1bb",
"main.dart.js_91.part.js": "a16396a7166219e7b96e55d62d371b9e",
"main.dart.js_8.part.js": "0986abe2bd269315abe0c99e9ed86dfa",
"main.dart.js_25.part.js": "ecb68ec57a7dd5e35022779f80f9834a",
"main.dart.js_103.part.js": "f1e9b20944cc890407ce7cce685cd2a1",
"main.dart.js_1.part.js": "7deac111155a74ad0afea8a45def4c2d",
"main.dart.js_3.part.js": "b7933a133446534edc4beb2327a1734c",
"main.dart.js_34.part.js": "62bc4b88bd8dc5091c20c953ce297cf8",
"main.dart.js_22.part.js": "041bb8929a684b53446b1ca57d0a8207",
"main.dart.js_14.part.js": "ba5af4abc8370e826578e8baffd7efea",
"main.dart.js_49.part.js": "8436adae494dc1a6536aa1c154acf5ab",
"main.dart.js_20.part.js": "85e704b9e8ab37cb740ca9a3e71d2b1b",
"main.dart.js_105.part.js": "a550288a6dce5fbdbbb10673673c6cc4",
"main.dart.js_6.part.js": "eb6a380a451a21354b4c34d63b2d083b",
"main.dart.js_87.part.js": "28e82b6505c38b50dc8c04f3689060fd",
"main.dart.js_46.part.js": "5d8e0809176bbc3d98b5243d52fed31f",
"main.dart.js_16.part.js": "f1d69483564e6f77b01682e23567ea25",
"main.dart.js_5.part.js": "976c86a59eae41dfcefb45f2c12e552d",
"main.dart.js_57.part.js": "c4dc79337a339499c3bcc30e87b63f45",
"main.dart.js_82.part.js": "a3027ceeef4732ebbfdc0a259d011b88",
"main.dart.js_17.part.js": "801f0e42a4e9a32421857c570eeff279",
"main.dart.js_36.part.js": "0ae383ca029afcdc0c2358cf56819367",
"main.dart.js_15.part.js": "8b8374e7040e5d0b6d8d339502a83124",
"main.dart.js_31.part.js": "cdc76e33880f75a008c78374009efbe5",
"main.dart.js_21.part.js": "5958ccfea86eca6f62d47273f24af06b",
"main.dart.js_10.part.js": "994c0f9e2d1b015cc9afeab5d4dab9d5",
"main.dart.js_73.part.js": "8aea865bfd6f9b1c20a591ddae1141ab",
"main.dart.js_93.part.js": "1c1ac0e56f1cb38f32e8774b4f27a034",
"main.dart.js_115.part.js": "bd46d8f45cb6d958dfed7d1d32674633",
"main.dart.js_54.part.js": "18361d4e5bc63c313ac7133481276661",
"main.dart.js_38.part.js": "37ff601f91571d3471dc246dbdc12b02",
"main.dart.js_116.part.js": "02cba299246c6fe15c683c52eae4253f",
"main.dart.js_74.part.js": "8f7a95880c35181f024f74e2d050f35c",
"main.dart.js_53.part.js": "c4235932520ca4fcb136bba7926ba420",
"main.dart.js_96.part.js": "1aeab4db9f5b76f6d1c99e3e3d5e3edd",
"main.dart.js_81.part.js": "2d10dfe0ae885cdff5a8fb9a4701d057",
"main.dart.js_19.part.js": "0a046bd2113c763c5110b24da6fcae5a",
"main.dart.js_18.part.js": "26edb6022d90d0d44deeeec577f6cfce",
"main.dart.js_84.part.js": "3a619a6daf4a8347db75a6d0757e68b5",
"main.dart.js_42.part.js": "3d6e13a0329a913efbe4bab36d8da291",
"main.dart.js_55.part.js": "c7c1c678e6f9fd80766aed45218f35f7",
"main.dart.js_107.part.js": "bc67cd5abf0ce74342b67ded3a4fa444",
"main.dart.js_44.part.js": "21c0139be7a7ae38ca6ec759aa9bf3d8",
"main.dart.js_65.part.js": "c43e7567bea83fd271b14b2dad61ac5c",
"main.dart.js_72.part.js": "58158b09fe158084fee38ae627f16bc8",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "2f4d388d6c2cff5e9036a12cba3db557",
"main.dart.js_85.part.js": "59129e780cf5586969d941ec2b827a5d",
"main.dart.js_108.part.js": "bb179061fcfb27bbf10a2d2cf8293e97",
"main.dart.js_59.part.js": "7600be20ca5a69a0c34ff71415705741",
"main.dart.js_94.part.js": "6b0c9583c1e0c6dfc26c1599bede70fc",
"main.dart.js_89.part.js": "434db64dd6a070816adee4f5caa6f7a3",
"main.dart.js_70.part.js": "2cce7a5bf128d707c92784557b98fc7f",
"main.dart.js_33.part.js": "b9a56426f586614c8957095c8954fce4",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "20430239510c177d46af001632f0bdd0",
"main.dart.js_24.part.js": "bbb69b2d60a04bd0eb9828642b9badaf",
"main.dart.js_48.part.js": "bb65fa84d96c413e7f3d1258b9bcb2c4",
"main.dart.js_92.part.js": "e80bf5d11d41261af73f2bad4a494143",
"main.dart.js_110.part.js": "b9957b90ce71300d73957b05ab129907",
"main.dart.js_104.part.js": "d78eb6908844a00941ec34f784355804",
"main.dart.js_11.part.js": "6dd58183f99f20156e2d399265259902",
"index.html": "3729d550786888bd12e96b5cf88dca4c",
"/": "3729d550786888bd12e96b5cf88dca4c",
"main.dart.js_4.part.js": "8c935f94e961075d0c66d1df273711d1",
"main.dart.js_97.part.js": "0ed4f051f4e562a90a9ccaf0b468c74e",
"main.dart.js_26.part.js": "22328b602891b8cd958bfc0926a94209",
"main.dart.js_47.part.js": "a2938d2feb6e9cf79fa8aef6280f9b23",
"main.dart.js_37.part.js": "6d5a8c40111817f7408cd356ee458a8b",
"main.dart.js_27.part.js": "83eaabafb619f3dfe95866fd36b260d7",
"main.dart.js_99.part.js": "816dce9da40401f2c65e45699f408b42",
"main.dart.js_13.part.js": "6a1890f287cb3a18ee99db800e3c0712",
"main.dart.js_112.part.js": "c108338881f27fc9d87250bb5cc348d5",
"main.dart.js_43.part.js": "f893bf8516e092d50056d666237cb9c6",
"main.dart.js_39.part.js": "9916d20bf4ed1ecca1329714744e3e7e",
"assets/AssetManifest.bin": "1c8696c7e2ed2e13e210ece64f186540",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "5345079f9e0e786b38bc77817b953141",
"assets/fonts/MaterialIcons-Regular.otf": "f54312b2958ffbec2235bb67bccd4970",
"assets/FontManifest.json": "3002a5264f22544b5ff394355b0605d5",
"assets/AssetManifest.json": "6f7aa652aee94761a5f9c398bb63293b",
"assets/shaders/earth_shader.frag": "caf56930d35615fe17651639db897543",
"assets/shaders/continents_land_only.frag": "7defb176bbb0ff96230a46658e11828a",
"assets/shaders/simple.frag": "0c2299d2b35041e8ce02cbf2404d1a27",
"assets/shaders/continents.frag": "065e06a6d824796a063cecd71a94cc56",
"assets/shaders/clouds.frag": "3bd92841974db1d2e588a0e56e0b8dc1",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/water_clouds.frag": "704f028da22dcab33db2ddda3180ca43",
"assets/NOTICES": "9c1692f49e2646eac51f22def6eece56",
"main.dart.js_88.part.js": "a3e3bf2d4ed9db891f5790d64de9fc65",
"main.dart.js_23.part.js": "760f8dc434ddeb76e37751f5cb59e29e",
"main.dart.js_67.part.js": "258dee73284a6070b903da63320e8bf0",
"main.dart.js_111.part.js": "72d43f155577e1171f4c61ce729767a3",
"main.dart.js_114.part.js": "e4ebe44e14bb038f28eb8e08fea6c982",
"main.dart.js_69.part.js": "fe2f124b1f6db1028eb88d6942f7486a",
"main.dart.js_100.part.js": "c730cdf7a2ae6d9f0d2eb2a7e2fa8221",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "a379ae64fcc554bb35396d9ded3c0e5e",
"main.dart.js_90.part.js": "71eb266d90d818a533b4c6803fe41563",
"main.dart.js_35.part.js": "de6617f8319be063c57eec3166669ab6",
"main.dart.js_52.part.js": "d65ef9f32525aeb32ec3e203f9dc1b2b",
"main.dart.js_95.part.js": "88d000795c282aaf466e6b830836a095",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "da95a898c7f3ce91fc1d0e0a6fabccf7",
"main.dart.js_2.part.js": "5b5d60268e86462a85a5fff0e0d6bf3f",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "c262438b8ddb888137402f31578545f7",
"main.dart.js_56.part.js": "4ede3fb50779518395aca408ca1ea0da",
"main.dart.js_80.part.js": "01ff0e06aedc46ed8883cdcad9b3b884",
"main.dart.js_86.part.js": "ce92eacc98c9700458fa5d8c05112190",
"main.dart.js_12.part.js": "46a91361474493587142abf7ae30b464"};
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
