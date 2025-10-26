'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "adf9f00f4ffe3f199cecaa3dd763e9e5",
"main.dart.js_98.part.js": "495d21853ddd85ba5bbc4632e0f9c1c0",
"main.dart.js_66.part.js": "e18e34b4e7c18059045c532eb64fa9ca",
"main.dart.js_63.part.js": "f4cac6d0e6e3dd37d14a3d2ca97ae556",
"main.dart.js_32.part.js": "34a1df0d770fbe562126419ddd01ea4b",
"main.dart.js_75.part.js": "ade8be6c1f23faa8b5538fa95205c76f",
"main.dart.js_9.part.js": "734c4484d5d697336bcb73cb0be42dac",
"flutter_bootstrap.js": "84cca9a502e1c1ed88c06a8b2522d08d",
"main.dart.js_61.part.js": "365908c7c957b6467ac08a53fe6de16f",
"main.dart.js_64.part.js": "8adf83e3196b5ab2c42856c22d0879db",
"main.dart.js_60.part.js": "b2643df11c6e1d4e328bda4166b432b2",
"main.dart.js_102.part.js": "9f8125bda36a3d3315893421fdd21aac",
"main.dart.js_76.part.js": "e0946134cd8006a2cb8a8fb4df15e986",
"main.dart.js_106.part.js": "fbcde99f18ec2e45f84563a236f4971d",
"main.dart.js_62.part.js": "d8d858cb778f1dc6b4811c7f7718396a",
"main.dart.js_68.part.js": "2974a992fb1fe396d77d4335b7bd7f32",
"main.dart.js_83.part.js": "301d1250612302e9d3dbc84d5a3907e2",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "bb3da2900796a95e84689b432284c2b5",
"main.dart.js_71.part.js": "ea53e4a600b15c0e61ab2d00c0936429",
"main.dart.js_41.part.js": "57f5ecec0ab3755218998c1db1e7233a",
"main.dart.js_50.part.js": "c9cc3bcd940fc9d2055fb8307a3d5cf9",
"main.dart.js_40.part.js": "e61dbacd2a3d01ad1fbbe8e7fe9903b7",
"main.dart.js_113.part.js": "172ea46a7b263ba6b1de0509c710fab6",
"main.dart.js_101.part.js": "79de5118084b812324d3a3796613884e",
"main.dart.js_30.part.js": "13d65b9cd44ad13d92c5bc7793aa80b6",
"main.dart.js_128.part.js": "76186c062424bdca95b8b8ceac0a1364",
"main.dart.js_51.part.js": "343c43aa6aaccb0bb0319887487f14c5",
"main.dart.js_28.part.js": "06ab7ccd1979fb3fc7da51e2a657bba4",
"main.dart.js_29.part.js": "9490917fb6e5b8f786e5471e3bf73937",
"main.dart.js_7.part.js": "a454d73d268d089e2a10b89147a07951",
"main.dart.js_91.part.js": "fda44f28d76d30ad5f45b186c3d55f62",
"main.dart.js_8.part.js": "4325414084ecb0e1f9f37c81a686ce0c",
"main.dart.js_25.part.js": "9775fc2f55bad29ab268dceff666e44b",
"main.dart.js_103.part.js": "d07340efd444d009054b7df983cd4f69",
"main.dart.js_1.part.js": "0c35237c3633144afaa2dd6f5df79a7c",
"main.dart.js_3.part.js": "d1265341625295ec2300d83b6daf4042",
"main.dart.js_34.part.js": "43a6f60ac4ff4fdc471e0014185d1710",
"main.dart.js_126.part.js": "06465f7fbbd55556fa80422ab2b78945",
"main.dart.js_22.part.js": "041bb8929a684b53446b1ca57d0a8207",
"main.dart.js_130.part.js": "8447fd8ae47fc99f7ff0be006b9a6f5c",
"main.dart.js_14.part.js": "7e8bd649551e8fe5e2a7dd6e33fce40a",
"main.dart.js_49.part.js": "05a690e5eee35ac91673599e13f2c08b",
"main.dart.js_20.part.js": "9cca7b4ed56a9156f9ede55fe6a8aacf",
"main.dart.js_118.part.js": "4e7bff5a71eec7e2d66ab957acd052e4",
"main.dart.js_105.part.js": "24ca170ef61a773d48ad2de172a0096d",
"main.dart.js_6.part.js": "622e3137bd03022b2d1bc64d8d67a461",
"main.dart.js_87.part.js": "f335af46808470fda6de34349514ac13",
"main.dart.js_46.part.js": "736474823e7c203a81b6c19e429c9544",
"main.dart.js_16.part.js": "ec82182945a6f55766bc8a2d4bedf6ad",
"main.dart.js_5.part.js": "28ce28a5288f0563dbc63b8edd03db93",
"main.dart.js_57.part.js": "03c6d73e5d837834e1c7cace59dc617d",
"main.dart.js_82.part.js": "49b137934f8ed43dcd35947bc9deada6",
"main.dart.js_17.part.js": "c88ac160557a8bfaae8af0e243dadd41",
"main.dart.js_36.part.js": "31b73d6213c722e399bf3acc694e3d62",
"main.dart.js_15.part.js": "2fa09556b199fdd2b455a1bbb564e7ef",
"main.dart.js_31.part.js": "4ccededf0b4ad7dfd0a2844792c59690",
"main.dart.js_21.part.js": "5958ccfea86eca6f62d47273f24af06b",
"main.dart.js_10.part.js": "d67884dbb8240593d0cd0c05cc23c584",
"main.dart.js_73.part.js": "27e2c6a7d901270e19894a04b77f67cd",
"main.dart.js_93.part.js": "6ed387d112248362bd34d154adb56811",
"main.dart.js_115.part.js": "53ba80793aa0c0351d2677c0b10c5b30",
"main.dart.js_119.part.js": "a6f6bb97c1d603f1680cafa1a14d6558",
"main.dart.js_54.part.js": "2edc5da44b8cd77d9b2de7c9fd22d410",
"main.dart.js_123.part.js": "8f7907b1bdaa78c2e54cdaf31db2cfcb",
"main.dart.js_38.part.js": "789e0864fac0d99551f37a5a5b4b3286",
"main.dart.js_117.part.js": "77cae536548d864317f4597d54ec7ce7",
"main.dart.js_116.part.js": "ba896e341c56b88c1b11199a9790de22",
"main.dart.js_74.part.js": "ba800b4ba43563e176c7067045d0413e",
"main.dart.js_125.part.js": "a5260219f0216479f63c91fd3ef61a36",
"main.dart.js_53.part.js": "bc06b8e03c36a5a079d11e5e43f97c3e",
"main.dart.js_96.part.js": "1f3618bf57c8702c0b21374f6d7a97df",
"main.dart.js_81.part.js": "fcd0306ebe9a965fe4bcc6f64b429454",
"main.dart.js_19.part.js": "dd212b90715db30321520db397e3072a",
"main.dart.js_18.part.js": "52a1d365024acd2a3b108ed2e9882d6c",
"main.dart.js_84.part.js": "bca8e8c306a420ec68210fd5917b9e5e",
"main.dart.js_129.part.js": "038470f6a7e5438e4711970c1434e9e3",
"main.dart.js_42.part.js": "e8114d4626fdd6dacec2919b76ad36aa",
"main.dart.js_55.part.js": "3ce554cd2cef034f7a6901fd879f1776",
"main.dart.js_107.part.js": "5eeea4f022dc10e472920da925ae85fb",
"main.dart.js_44.part.js": "10a7317123d04a01e27149faa12ee191",
"main.dart.js_65.part.js": "635d4abab5c132a1e362fc0e8cf7ccbb",
"main.dart.js_72.part.js": "a2166ea576997c9047af2b99574ad254",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "ac7db58f1dd10fba0206e1e0fc848763",
"main.dart.js_85.part.js": "78b6210b56df47741c9f4dae35f004c5",
"main.dart.js_108.part.js": "59e3776d94a901594fb8321f1e91a0e4",
"main.dart.js_59.part.js": "68d218281d426b81d682af347dcf888b",
"main.dart.js_94.part.js": "38514005f3fb0d4eebe0c9004d2fd5bb",
"main.dart.js_89.part.js": "2a54a66724764d64dafab63cbd8c01d1",
"main.dart.js_70.part.js": "22cc7a888622a57f4d493cf3966fd40f",
"main.dart.js_33.part.js": "11eb4054de90c55f256f3cf8d5b1e568",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "6ad2fff7ad8516492352d80f0d0cf4ce",
"main.dart.js_24.part.js": "af938c394965241ad222c0e7ecd67a48",
"main.dart.js_48.part.js": "8ae871e7cea975d03faa4e32ac4f356a",
"main.dart.js_92.part.js": "5541b995b5d5cccd9bf0eb5742e2b33e",
"main.dart.js_110.part.js": "04e3a1ebaf5b211aeb18eaf3f56fa97a",
"main.dart.js_104.part.js": "dac0fe6c09a795a53883e2d683753e7e",
"main.dart.js_11.part.js": "53cce171cdeb1f4ce6ac95d07a189e0b",
"main.dart.js_124.part.js": "05e8b07ff1387ecfacba60aacbefd685",
"index.html": "82b2b56fc1dbb6c967c1c5e00bbb3ac7",
"/": "82b2b56fc1dbb6c967c1c5e00bbb3ac7",
"main.dart.js_4.part.js": "9367a67d935184ccebb6054d1ab97121",
"main.dart.js_97.part.js": "4826bf5acb0a9b5bb0e8710e5750e091",
"main.dart.js_26.part.js": "4f7d6463cca3bc594bdb45135bc7d518",
"main.dart.js_47.part.js": "6a007a50de89bf2383c69d6784beefbe",
"main.dart.js_127.part.js": "9dff5da0185198e0db696a39fa4c7187",
"main.dart.js_37.part.js": "fd4003eef0ca578198af301d0930aadf",
"main.dart.js_27.part.js": "58e31ceb79657fdcab98937bdd33d990",
"main.dart.js_99.part.js": "435b19e623a8054ad4fb390ad8e09138",
"main.dart.js_13.part.js": "adf6fa8b8745a7202c872749e0886667",
"main.dart.js_112.part.js": "c527fcfe712da70d9a92ece3503f5f5f",
"main.dart.js_43.part.js": "0e9448584d4cdc2f08107af7de26a764",
"main.dart.js_39.part.js": "e47dc7edbac61145a72096ee4e45ba8c",
"assets/AssetManifest.bin": "eb9126b4e5ae49971137bb64d6cff5f3",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "3ef8031b6c1baa93e3f709a6f2cdfdad",
"assets/fonts/MaterialIcons-Regular.otf": "9649c910cb9c46700f2a0d26fadda2fb",
"assets/FontManifest.json": "5bf5570bf3efc7b2862937a369b1b0df",
"assets/AssetManifest.json": "e4dae148b301d722c5fc55a227712fab",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "e949713f8bb3a755d44ac95a5a424214",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "4b07d4c4ec0467f14ca66b3c172e37de",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "4d19cee7561236345fd9d979bdc15314",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/water_clouds.frag": "704f028da22dcab33db2ddda3180ca43",
"assets/NOTICES": "4285cfd938c0dbf845be004aa6c43218",
"main.dart.js_88.part.js": "1f64725dd9fff06813237808ad4f0022",
"main.dart.js_120.part.js": "505e3e4ce3114b2e68d0221446b5928b",
"main.dart.js_23.part.js": "4a379d568383949af5737742955d9b24",
"main.dart.js_121.part.js": "5a800c03f70d59c5d9f05a0ef63af55a",
"main.dart.js_67.part.js": "c5180506dd4072df9a87573c25618463",
"main.dart.js_111.part.js": "a60a9ff6416ad2c100967bb8203c12b1",
"main.dart.js_114.part.js": "e28dce683bde3faca13758c090b7bb7f",
"main.dart.js_122.part.js": "dc60eb7b5caa019c57dafc07726d26df",
"main.dart.js_69.part.js": "a639dfd3ba229b17787181ada995543f",
"main.dart.js_100.part.js": "6a7d6a4fc4de18ea7e050f8cb044bbcc",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "424d6daefd62cebed56d416022e36b25",
"main.dart.js_90.part.js": "0b23a74e49c7ab71ce3e1926bdb705c6",
"main.dart.js_35.part.js": "c70f6a0014c6277a32d33ebbc5bd99b1",
"main.dart.js_52.part.js": "b960767ab421c301a71f3c0c55e4d4b3",
"main.dart.js_95.part.js": "2ad784d7ee83ae4b936e384a48e4771a",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "6059ac359adbd6ad905231200f55d1d6",
"main.dart.js_2.part.js": "4c1b2b8b996a91d09d4df9dd4eb73577",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "b30983ad019b0e50bbcb2de6f062b4c4",
"main.dart.js_56.part.js": "f0e55d98af4742a1e759e0c7582c5456",
"main.dart.js_80.part.js": "1d1762ffccf240f850cfd3e89d81ed5c",
"main.dart.js_86.part.js": "f16f1fd5b0b44d87fa903c521d3646d3",
"main.dart.js_12.part.js": "71178385d59be82be5da32efd126da0b"};
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
