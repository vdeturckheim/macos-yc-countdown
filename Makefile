VERSION ?= 1.0
DMG = dist/YC-X26-countdown-$(VERSION).dmg

.PHONY: dmg tag release cask clean

dmg:
	bash scripts/create-dmg.sh $(VERSION)

tag:
	git tag -a v$(VERSION) -m "Release v$(VERSION)"
	git push origin v$(VERSION)

release: dmg tag
	gh release create v$(VERSION) $(DMG) \
		--title "v$(VERSION)" \
		--notes "YC X26 Countdown v$(VERSION)"

cask:
	@shasum -a 256 $(DMG) | awk '{print "sha256: " $$1}'

clean:
	rm -rf dist/
