---
title: Mini-Server
includes: [lightbox]
---

Several people have asked me about the mini-server I have set up. First I will summarise the way I intend to use the machine, then explain how I took those guidelines to make requirements for each component and finally I'll list the components selected.

## How The Machine Will Be Used

* On 24/7 (much of the time idle)
* Running services including:
    * MySQL
    * Tomcat (running on OpenJDK)
    * NFS
    * Samba
    * Squeezebox Server
* Data will be backed up regularly to 2.5” 7200 rpm USB disks.

## Considerations Based on the Requirements

### CPU

Until the [Zero-Assembler Project](http://openjdk.java.net/projects/zero/) is complete, OpenJDK supports only a limited number of CPU platforms. The 2 platforms that are most suitable for a mini-server are x64 or ARM. Of these, only x64 is supported by OpenJDK. All x64 CPUs should be capable of running the currently foreseen programs. A low power CPU would be preferable. The most popular choices are:

* Intel Atom D2700
* AMD E350
* AMD E450

To this list I will add a slightly unusual candidate:

* Intel Celeron 847

For this server, it will be in a near idle state more that it will be active. Idle energy consumption should be a reasonable predictor of actual energy consumption. The power of the combination of CPU, chipset and motherboard is more important than the CPU in isolation.

There is a comparison of several motherboards at [hardware.info](http://uk.hardware.info/reviews/3316/12/mini-itx-motherboards-review---part-1-integrated-cpu-energy-consumption). The lowest power consumption for each CPU type is included in the table below (note the worst performing boards draw >50% more power than the best). The website does not list a Celeron 847 motherboard, so for that CPU, I have taken the figures from [silentpcreview.com](http://www.silentpcreview.com/forums/viewtopic.php?p=570472&amp;sid=60c04b2b348b9771c5e02cb3ff320c34#p570472)

Clock speed is quite a poor indicator of CPU performance when comparing different architectures. A better comparison is to use a benchmark. I've added the figures from [cpubechmark.net](http://www.cpubechmark.net/) to the table below.

CPU|Clock Speed (GHz)|TDP (W)|Idle (W)|PassMark
-|-|-|-|-
AMD E350|1.6|18|20.0|[609](http://www.cpubenchmark.net/cpu.php?id=1777)
AMD E450|1.7|18|22.9|[805](http://www.cpubenchmark.net/cpu.php?id=250)
Intel Atom D2700|2.13|13|21.3|[833](http://www.cpubenchmark.net/cpu.php?id=607)
Intel Celeron 847|1.1|17|20.0|[1046](http://www.cpubenchmark.net/cpu.php?id=661)

The Celeron draws the equal lowest power and in the benchmark out performs the other CPUs significantly. This surprised me, investigating further I found that the Celeron performs graphics tasks quite poorly, so for many applications the more popular CPUs would actually be a better fit. For my use though the Celeron looks ideal, so I have used that CPU.

### Disks etc

All data (including operating system) is stored on a RAID mirror. In case of a single drive failure the machine will continue to function. There are 3 options for RAID: software, firmware or hardware. There are low power motherboards available that have firmware RAID but none that have proper hardware RAID built in. To use hardware RAID an expensive addon card would be needed. RAID 1 (mirroring) is the least complex RAID level, a hardware RAID controller will usually only slightly out perform software RAID - it didn't seem worth it for this machine. There is no standard for how firmware RAID controllers store data on the disk. This can make recovering data from the drive difficult if the controller fails. With a drive taken from a Linux RAID mirror, it is very easy to mount even for example if the drive is in an external caddy, so I've used Linux RAID.

Many of the tasks will not require fast disk IO, however the one that will be most affected is bulk backups. The performance of a bulk backup will be at most as fast as the backup medium. The fastest backup disk is a [Hitachi Travelstar 7k500](http://www.storagereview.com/hitachi_travelstar_7k500_review). CrystalDiskMark 500MB sequential transfer test shows a maximum read rate of 110.4 MB/s. For the mini-server the lowest power 500GB hard drive that supports comparable throughput would be ideal. The first 4 rows in the table show typical values for 2.5" and 3.5" drives in 5400 rpm and 7200 rpm spindle speeds.

Model|Physical Size|Spindle Speed|IO Meter 2MB sequential read|Max CrystalDiskMark 500MB|Idle Power (W)
-|-|-|-|-|-
[Western Digital Caviar Black](http://www.storagereview.com/western_digital_caviar_black_review_2tb)|3.5"|7200|133.04|145.4|6.41
[Western Digital Caviar Blue](http://www.storagereview.com/western_digital_caviar_blue_1tb_review_wd10ealx)|3.5"|5400|131.0|149.9|5.47
[Western Digital Scorpio Black](http://www.storagereview.com/western_digital_scorpio_black_500gb_review_wd5000bekt)|2.5"|7200|103.54|110.2|0.99
[Western Digital Scorpio Blue](http://www.storagereview.com/western_digital_scorpio_blue_review_750gb_wd7500bpvt)|2.5"|5400|93.03|99.66|0.63
[Western Digital Scorpio Blue (WD5000LPVT)](http://www.storagereview.com/western_digital_scorpio_blue_review_500gb_7mm_wd5000lpvt)|2.5"|5400|116.58|120.8|0.6

The last row shows a single platter 2.5" drive which is idea for this server. The read speed is faster than typical 7200 rpm drives and it consumes less power when idle than typical 5400 rpm drives. Note I've listed the exact model number as there are other drives that are named "Scorpio Blue 500GB" that are multi-platter drives and do not have these characteristics.

### Connectivity

USB 2.0 can theoretically support data transfers of 60MB/s which is around half the peak sequential read and write speed of the internal and external drives. The faster alternatives are USB3 or eSATA. My laptop supports USB3 and in general is more widely supported (especially due to backwards compatibility), so I've opted for USB3.

### Case / PSU

The [Antec ISK 110](http://www.anandtech.com/show/6192/antec-isk-110-vesa-case-review-just-about-as-small-as-it-gets) is compact, with good ventilation and a 92% efficient PSU. It accommodates 2x2.5" drives but provides almost no superfluous space.

### Misc ###
I only found 1 family of motherboards that have Celeron 847 CPUs and supports USB3 on the chipset. Due to the small CPU heatsinks, a fan is required. The 40mm fan that is provided with the motherboard spins quite fast and is quite noisy. because of the close proximity of the CPU to the mesh side of the case it is possible to mount a fan to the case that causes air flow through the heat sink. Noctura make premium fans that are efficient, quiet and come with a 5 year warranty. I selected a 140mm fan that supports PWM speed control. The speed is controlled through the BIOS based on the temperature. Once booted but idle, with the stock fan and an ambient temperature of 18℃ the CPU temperature remains about 40℃. With the Noctura running at 60% duty cycle (the lowest this BIOS supports) the CPU idles at about 29℃. The fan is quiet but not quite silent. When the hard disks are active they are considerably louder than the fan. 

## Component List

Item|Description|Price
-|-|-
Motherboard/CPU|Asus C8HM70-W/HDMI|£63.04
Fan|Noctura NF-A9x14|£14.95
Memory|Corsair Vengeance 8GB DDR3|£39.22
Hard Drives|2x Western Digital Scorpio Blue 500GB 7mm (WD5000LPVT)|£83.83
Case / PSU|Antec ISK 110|£69.57
Total||£270.61

## Performance
So far every task I've used it for has performed as expected. Restoring data from an external drive over USB3 averaged over 70MB/s even though many of the files were small. When booted but sitting idle, the power consumption is steady at 17.5W. I think this is good - the energy consumption is less than most of the single disk system on the market. I have also written a sleeponlan script that suspends the machine when inactive for a while. I'll post some info on that later.

## Photos

{% lightbox --group photos /images/mini-server/0.jpg --alt "Left side of the server" --title "Note the brown rubber posts that the fan is mounted on" %}
{% lightbox --group photos /images/mini-server/1.jpg --alt "Right side of the server" --alt again %}
{% lightbox --group photos /images/mini-server/2.jpg --alt "Internal view of the server" %}
{% lightbox --group photos /images/mini-server/3.jpg --alt "Outside of the server showing whole to mount fan" --title "Near the bottom of the image is a hole I made to mount the fan" %}
{% lightbox --group photos /images/mini-server/4.jpg --alt "Inside view of the side panel, showing the fan mountings" --alt-title %}

