# Maintainer: inferno0230 <mail@inferno0230.in>

pkgname=radxa-aic8800-usb-dkms
pkgver=5.0+git20260123.5f7be68d
pkgrel=1
_upstream_pkgrel=4
_debver="${pkgver}-${_upstream_pkgrel}"
_urlver="5.0%2Bgit20260123.5f7be68d-${_upstream_pkgrel}"
_release_url="https://github.com/radxa-pkg/aic8800/releases/download/${_urlver}"
pkgdesc="DKMS USB driver and firmware for AIC8800 Wi-Fi devices from Radxa"
arch=('any')
url="https://github.com/radxa-pkg/aic8800"
license=('custom')
depends=('dkms')
source=(
  "aic8800-firmware_${_debver}_all.deb::${_release_url}/aic8800-firmware_${_urlver}_all.deb"
  "aic8800-usb-dkms_${_debver}_all.deb::${_release_url}/aic8800-usb-dkms_${_urlver}_all.deb"
)
sha256sums=('7f242b1cd65fb4961758b8cb5c6765a1d124ca8ccab38df802c3e01801e3e6a4'
            '52fd66ec68d746987667f5ae2ecc5f12ad40177d28631ff50704e93d49a39d74')

_extract_deb() {
  local deb="$1"
  local dest="$2"
  local data_tar

  install -d "${dest}/root"
  bsdtar -xf "${srcdir}/${deb}" -C "${dest}"
  data_tar="$(find "${dest}" -maxdepth 1 -name 'data.tar.*' -print -quit)"
  bsdtar -xf "${data_tar}" -C "${dest}/root"
}

package() {
  local extract_dir="${srcdir}/deb-root"
  local fw_root="${extract_dir}/firmware/root"
  local usb_root="${extract_dir}/usb/root/usr/src/aic8800-usb-${_debver}"

  rm -rf "${extract_dir}"
  _extract_deb "aic8800-firmware_${_debver}_all.deb" "${extract_dir}/firmware"
  _extract_deb "aic8800-usb-dkms_${_debver}_all.deb" "${extract_dir}/usb"

  install -d "${pkgdir}/usr/src"
  cp -a "${usb_root}" "${pkgdir}/usr/src/aic8800-usb-${pkgver}"

  sed -i \
    -e "s|PACKAGE_VERSION=.*|PACKAGE_VERSION=\"${pkgver}\"|" \
    "${pkgdir}/usr/src/aic8800-usb-${pkgver}/dkms.conf"

  find "${pkgdir}/usr/src" -type f \( \
    -name '*.o' -o \
    -name '*.ko' -o \
    -name '*.a' -o \
    -name '*.cmd' -o \
    -name '*.mod' -o \
    -name '*.mod.c' -o \
    -name 'modules.order' -o \
    -name 'Module.symvers' \
  \) -delete
  find "${pkgdir}/usr/src" -type d \( -name '.tmp_versions' -o -name '.git' \) -prune -exec rm -rf {} +

  install -d "${pkgdir}/usr/lib/firmware/aic8800_fw"
  cp -a "${fw_root}/lib/firmware/aic8800_fw/USB" "${pkgdir}/usr/lib/firmware/aic8800_fw/"

  install -Dm644 "${fw_root}/usr/share/doc/aic8800-firmware/copyright" \
    "${pkgdir}/usr/share/licenses/${pkgname}/copyright"
  install -Dm644 "${fw_root}/usr/share/doc/aic8800-firmware/changelog.Debian.gz" \
    "${pkgdir}/usr/share/doc/${pkgname}/changelog.Debian.gz"
}
