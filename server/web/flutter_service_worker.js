'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "45bee8dc0bdd4fca662a86b4866f90c4",
"main.dart.js_98.part.js": "19ab5030d7872db486ec311100f1cdc4",
"main.dart.js_66.part.js": "9afa68450d764b86031e9c81464faf57",
"main.dart.js_63.part.js": "4580a38dbffcbc0ec2c8d106c9d4717c",
"main.dart.js_32.part.js": "4570ca7dbca2edf890302577d37b8004",
"main.dart.js_75.part.js": "e435de32981a2d56dca1747ea6154bfb",
"main.dart.js_9.part.js": "fcddaa043bd29ad1baf7528b589b35b9",
"flutter_bootstrap.js": "6e9c1f000c3d1759f4b451a52b52f662",
"main.dart.js_61.part.js": "5881bda66802df949c1a91d8cd0e4ede",
"main.dart.js_64.part.js": "0203a0eec62a1858965b4080e394205c",
"main.dart.js_60.part.js": "9b2dc5879e9fd2d9c23d9929f9daebbc",
"main.dart.js_102.part.js": "acab9c39f7b39332503be8e5012f4b14",
"main.dart.js_76.part.js": "ae0f78914c9b8a1b2ebd27c8da1fbecb",
"main.dart.js_106.part.js": "1b3d63184141f531a2e8669f40b9930a",
"main.dart.js_62.part.js": "d8d858cb778f1dc6b4811c7f7718396a",
"main.dart.js_68.part.js": "e533329a882510fb0d2a341292137691",
"main.dart.js_83.part.js": "0f7632004eaad05340add02921affad4",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"main.dart.js_79.part.js": "4120a6a39c3aa88937467627b568bca4",
"main.dart.js_71.part.js": "77744b05bd9b0f1d14f7efea91e9a804",
"main.dart.js_41.part.js": "5e7598afd15b9a696eaf33c141fdf609",
"main.dart.js_50.part.js": "6e76516f5afdb7eca5d97013fbe13f20",
"main.dart.js_40.part.js": "df6323b0b549408d759c7fa9b5799ccf",
"main.dart.js_113.part.js": "172ea46a7b263ba6b1de0509c710fab6",
"main.dart.js_101.part.js": "89d35925460ea4fee354447a968e05c6",
"main.dart.js_30.part.js": "248fd8aecd9045f84328b6d05b2971bf",
"main.dart.js_128.part.js": "76186c062424bdca95b8b8ceac0a1364",
"main.dart.js_51.part.js": "343c43aa6aaccb0bb0319887487f14c5",
"main.dart.js_28.part.js": "e622a3e8c84ee875e225373f08eeee75",
"main.dart.js_29.part.js": "3894bc690047e686eb15c8e57f626374",
"main.dart.js_7.part.js": "a454d73d268d089e2a10b89147a07951",
"main.dart.js_91.part.js": "5ae88264030a94d01997c4dfb54d543b",
"main.dart.js_8.part.js": "ab0a2b0ad695a3d69777978f86cf7eb1",
"main.dart.js_25.part.js": "9775fc2f55bad29ab268dceff666e44b",
"main.dart.js_103.part.js": "1b6f29851b01071625a6ed4c536f6f7a",
"main.dart.js_1.part.js": "113308462f585c90861d2d63c6017355",
"main.dart.js_3.part.js": "93a9f2e9ea30d07778fac358901fdb5b",
"main.dart.js_34.part.js": "d7fba9cf2117c4302028f769836c1bb6",
"main.dart.js_126.part.js": "06465f7fbbd55556fa80422ab2b78945",
"main.dart.js_22.part.js": "041bb8929a684b53446b1ca57d0a8207",
"main.dart.js_130.part.js": "8447fd8ae47fc99f7ff0be006b9a6f5c",
"main.dart.js_14.part.js": "508925c7ce722e17524a31ebb802fe6f",
"main.dart.js_49.part.js": "05a690e5eee35ac91673599e13f2c08b",
"main.dart.js_20.part.js": "9cca7b4ed56a9156f9ede55fe6a8aacf",
"main.dart.js_118.part.js": "4e7bff5a71eec7e2d66ab957acd052e4",
"main.dart.js_105.part.js": "bb035e9d91840963311a7f2c959709d2",
"main.dart.js_6.part.js": "3c48705f3451c3c1a2fbce51c09cbd01",
"main.dart.js_87.part.js": "f335af46808470fda6de34349514ac13",
"main.dart.js_46.part.js": "4cee0815a1ac395fd55fc21e5739cb11",
"main.dart.js_16.part.js": "b2ee81ff9bc959ef9791c691914ad930",
"main.dart.js_5.part.js": "3a0315eed0eb2a88fb5958e9e10a840b",
"main.dart.js_57.part.js": "52cc5772a66b66e9247b264c34571ee6",
"main.dart.js_82.part.js": "da178e89354386514a31c03541fe14ce",
"main.dart.js_17.part.js": "c88ac160557a8bfaae8af0e243dadd41",
"main.dart.js_36.part.js": "31b73d6213c722e399bf3acc694e3d62",
"main.dart.js_15.part.js": "9af9e060f53377b142b1b2fc0f224494",
"main.dart.js_31.part.js": "3f83158e85dc65fa4384c50d61e221f5",
"main.dart.js_21.part.js": "5958ccfea86eca6f62d47273f24af06b",
"main.dart.js_10.part.js": "6977060f5dccbee8e0847acac532cf33",
"main.dart.js_73.part.js": "395f0fffce8524e159395a9bffcb8804",
"main.dart.js_93.part.js": "af31a658122911a0d867f8e86fad6c0e",
"main.dart.js_115.part.js": "53ba80793aa0c0351d2677c0b10c5b30",
"main.dart.js_119.part.js": "a6f6bb97c1d603f1680cafa1a14d6558",
"main.dart.js_54.part.js": "adf01f189f204351e974ed97a140fed7",
"main.dart.js_123.part.js": "8f7907b1bdaa78c2e54cdaf31db2cfcb",
"main.dart.js_38.part.js": "7261ac2004ed28460c24d6f810e3ff72",
"main.dart.js_117.part.js": "77cae536548d864317f4597d54ec7ce7",
"main.dart.js_116.part.js": "ba896e341c56b88c1b11199a9790de22",
"main.dart.js_74.part.js": "ba800b4ba43563e176c7067045d0413e",
"main.dart.js_125.part.js": "a5260219f0216479f63c91fd3ef61a36",
"main.dart.js_53.part.js": "bc06b8e03c36a5a079d11e5e43f97c3e",
"main.dart.js_96.part.js": "b790eabec55f64a7b2d7dfde91ca8437",
"main.dart.js_81.part.js": "fcd0306ebe9a965fe4bcc6f64b429454",
"main.dart.js_19.part.js": "dd212b90715db30321520db397e3072a",
"main.dart.js_18.part.js": "39a4f824d3bb905726a4927a5591a750",
"main.dart.js_84.part.js": "71128b0d131bfa89f1c59c5ebc25caf5",
"main.dart.js_129.part.js": "038470f6a7e5438e4711970c1434e9e3",
"main.dart.js_42.part.js": "e8114d4626fdd6dacec2919b76ad36aa",
"main.dart.js_55.part.js": "d262fb9accc55166a8a7d0fec237fd4e",
"main.dart.js_107.part.js": "f095fc6f62ae9c5cfb417e7f50478056",
"main.dart.js_44.part.js": "10a7317123d04a01e27149faa12ee191",
"main.dart.js_65.part.js": "81ff9c8c1c8f8dd08bf16547aa853d8f",
"main.dart.js_72.part.js": "5f1b8ec5e4554c222819dfd2064dce71",
"icons/Icon-maskable-512.png": "274a1e917760a1f046d666e6202d023a",
"icons/Icon-maskable-96.png": "91ebf99f57762a0a291d74ca8992d18c",
"icons/Icon-maskable-128.png": "246028210ed2ad790833d9bae1456df3",
"icons/Icon-192.png": "de2ec02df3a1869af4ad786b508d58d0",
"icons/Icon-maskable-192.png": "0bf4a53e4bdef76509c1639561988a14",
"icons/Icon-512.png": "80a96cdf564eb56bf72144a81d528408",
"main.dart.js_77.part.js": "fb882b1a78809748821dc14e50a2f5a6",
"main.dart.js_85.part.js": "78b6210b56df47741c9f4dae35f004c5",
"main.dart.js_108.part.js": "b4efdae4c437a06f41cee22c5982b7b6",
"main.dart.js_59.part.js": "7b1b1945f4bd7b1f61c094a7cdf294b9",
"main.dart.js_94.part.js": "43bf275d6626033a2e4daa588896ff95",
"main.dart.js_89.part.js": "3b9e8e3e5db3e54ff1eb96dfc7c639fd",
"main.dart.js_70.part.js": "3428b1cca5b19bc46792c1d1154411d4",
"main.dart.js_33.part.js": "b5a34727fbcd955e5973c4fb03dfa1e3",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js_58.part.js": "0c60ef1f060573b347b9623cf8b750ee",
"main.dart.js_24.part.js": "bd8481fe64c6da472752e66e0617e19a",
"main.dart.js_48.part.js": "0c960e90e7af0c6d83f733baf30c5dc8",
"main.dart.js_92.part.js": "f92bc24e934a10448e52cb6c38c78340",
"main.dart.js_110.part.js": "5aedbc2180a289e7faf172302afc5584",
"main.dart.js_104.part.js": "48f535fb528873917627a96adcd8cdcb",
"main.dart.js_11.part.js": "c0a5b8d7b3ec1d4742b1f4dd99bcd176",
"main.dart.js_124.part.js": "05e8b07ff1387ecfacba60aacbefd685",
"index.html": "82b2b56fc1dbb6c967c1c5e00bbb3ac7",
"/": "82b2b56fc1dbb6c967c1c5e00bbb3ac7",
"main.dart.js_4.part.js": "15348fdf47383f59afbb3019dd349290",
"main.dart.js_97.part.js": "cfdc652acf9d74b264ff4bbb3a58033d",
"main.dart.js_26.part.js": "4f7d6463cca3bc594bdb45135bc7d518",
"main.dart.js_47.part.js": "335b8c2b43fc6e21dc890ed2b56a6acf",
"main.dart.js_127.part.js": "9dff5da0185198e0db696a39fa4c7187",
"main.dart.js_37.part.js": "1f31c1b300c92ee0b0c2f7fbf613ad8c",
"main.dart.js_27.part.js": "58e31ceb79657fdcab98937bdd33d990",
"main.dart.js_99.part.js": "b58c0080da3f309409534dfbaebfc596",
"main.dart.js_13.part.js": "b7691ffd485b802c543464c8f8665197",
"main.dart.js_112.part.js": "c527fcfe712da70d9a92ece3503f5f5f",
"main.dart.js_43.part.js": "0e9448584d4cdc2f08107af7de26a764",
"main.dart.js_39.part.js": "ee4af3f6e718f8359d84e57c89debe7f",
"assets/AssetManifest.bin": "eb9126b4e5ae49971137bb64d6cff5f3",
"assets/cargoship/iconttf/RpgAwesome.ttf": "3fb8d0aa42860e8db819f5d3c65834c5",
"assets/cargoship/builtin_fonts/Palatino_bold.ttf": "975972a205fd91a532d1b7433281af70",
"assets/cargoship/builtin_fonts/Palatino_italic.ttf": "be4590eba976dace111b6686f6dade52",
"assets/cargoship/builtin_fonts/Rubik-VariableFont_wght.ttf": "6d3102fa33194bef395536d580f91b56",
"assets/cargoship/builtin_fonts/Palatino_roman.ttf": "96261bb90c9babbf8042ce7f43200d65",
"assets/cargoship/builtin_fonts/Palatino_bolditalic.ttf": "beef66370e7124eb683514ad9ad07576",
"assets/AssetManifest.bin.json": "3ef8031b6c1baa93e3f709a6f2cdfdad",
"assets/fonts/MaterialIcons-Regular.otf": "abb8fe8bf81a2d878b91076b8ab9e916",
"assets/FontManifest.json": "5bf5570bf3efc7b2862937a369b1b0df",
"assets/AssetManifest.json": "e4dae148b301d722c5fc55a227712fab",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsSharp.ttf": "e949713f8bb3a755d44ac95a5a424214",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsOutlined.ttf": "9bcb1a1a0087750a763b23d5c337c78d",
"assets/packages/material_symbols_icons/lib/fonts/MaterialSymbolsRounded.ttf": "4d19cee7561236345fd9d979bdc15314",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/water_clouds.frag": "704f028da22dcab33db2ddda3180ca43",
"assets/NOTICES": "4285cfd938c0dbf845be004aa6c43218",
"main.dart.js_88.part.js": "64e03663717164226125b4902e7a5ec1",
"main.dart.js_120.part.js": "505e3e4ce3114b2e68d0221446b5928b",
"main.dart.js_23.part.js": "760f8dc434ddeb76e37751f5cb59e29e",
"main.dart.js_121.part.js": "5a800c03f70d59c5d9f05a0ef63af55a",
"main.dart.js_67.part.js": "03abf311503cfeb3d44a77939b15be26",
"main.dart.js_111.part.js": "f5a4a3284f59be2e077340c668ed0727",
"main.dart.js_114.part.js": "e28dce683bde3faca13758c090b7bb7f",
"main.dart.js_122.part.js": "dc60eb7b5caa019c57dafc07726d26df",
"main.dart.js_69.part.js": "b5c30c178bebef169b6cfb739e70f107",
"main.dart.js_100.part.js": "6a7d6a4fc4de18ea7e050f8cb044bbcc",
"manifest.json": "38212b39dd51df343b19bfa938e9ac4f",
"main.dart.js_78.part.js": "f91c7cbf05b082d6fce6dad5d4e25e97",
"main.dart.js_90.part.js": "45c63655486fb72c6346483e042231a2",
"main.dart.js_35.part.js": "9f7619293aa38032eced620704eeb303",
"main.dart.js_52.part.js": "b960767ab421c301a71f3c0c55e4d4b3",
"main.dart.js_95.part.js": "6aa549a194e47f2019ee68092a281818",
"version.json": "6b8b9140b83c40f85633ddfcd9f81cd7",
"main.dart.js_109.part.js": "e49de6860082353518ab7991684e547c",
"main.dart.js_2.part.js": "168f1186092e7b5e329157bdb8cd76b6",
"favicon.png": "306e7ba8f0872a8ae25be6aca7d80b7f",
"main.dart.js_45.part.js": "bf70255e572ffa79cb3bcf1ec3654757",
"main.dart.js_56.part.js": "779d1f9ee11b3d1312169d880d2e1c64",
"main.dart.js_80.part.js": "bc6e2448accd41b2bf70041147cbae51",
"main.dart.js_86.part.js": "f16f1fd5b0b44d87fa903c521d3646d3",
"main.dart.js_12.part.js": "fa6d2d6ed1afc3d2c48af10476a92a8c"};
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
