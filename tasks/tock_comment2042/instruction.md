# Code Review Task

You are a maintainer reviewing a pull request to the `tock/tock` repository.

**PR title:** Intel 8080 parallel interface HIL, Bus library with I2C, SPI and Intel 8080 parallel interface implementation

**PR description:**

### Pull Request Overview

Several hardware components work with the same protocol over several buses. For instance, sensors like l3gd20, lsm303 work over I2C and SPI, screens like ST7735 and ST7789H2 work over SPI or Intel 8080 parallel interface. Using the Bus library, capsules for these devices will work regardless of which hardware communication bus is used.

This PR
  * adds screen support for stm32f412gdiscovery
  * adds FSMC support for stm32f4xx
  * a Intel 8080 parallel interface (Bus8080) HIL
  * changes st7735 driver to st77xx single driver for ST7735 , ST7789H2 and LS016B8UY (reversed engineered, no documentation available) over the new Bus HIL
  * fixes the screen HIL and capsule (adds a `write_continue` function to the screen trait)

#### Intel 8080 parallel interface HIL

```rust
pub trait Bus8080<'a> {
    /// Set the address to write to
    fn set_addr(&self, addr_width: BusWidth, addr: usize) -> ReturnCode;

    /// Write data items to the previously set address
    fn write(&self, data_width: BusWidth, buffer: &'static mut [u8], len: usize) -> ReturnCode;

    /// Read data items from the previously set address
    fn read(&self, data_width: BusWidth, buffer: &'static mut [u8], len: usize) -> ReturnCode;

    fn set_client(&self, client: &'a dyn Client);
}

pub trait Client {
    /// Called when set_addr, write or read are complete
    ///
    /// set_address does not return a buffer
    /// write and read return a buffer
    /// len should be set to the number of data elements written
    fn command_complete(&self, buffer: Option<&'static mut [u8]>, len: usize);
}
```

The Bus8080 HIL is required as FSMC seems to be specific to STMs and is used to connect devices that support Parallel 8080 interface. Several screens work with this interface.


#### Bus Librarry

```rust
pub trait Bus<'a> {
    /// Set the address to write to
    ///
    /// If the underlaying bus does not support addresses (eg UART)
    /// this function returns ENOSUPPORT
    fn set_addr(&self, addr_width: BusWidth, addr: usize) -> ReturnCode;

    /// Write data items to the previously set address
    ///
    /// data_width specifies the encoding of the data items placed in the buffer
    /// len specifies the number of data items (the number of bytes is len * data_width.width_in_bytes)
    fn write(&self, data_width: BusWidth, buffer: &'static mut [u8], len: usize) -> ReturnCode;

    /// Read data items from the previously set address
    ///
    /// data_width specifies the encoding of the data items placed in the buffer
    /// len specifies the number of data items (the number of bytes is len * data_width.width_in_bytes)
    fn read(&self, data_width: BusWidth, buffer: &'static mut [u8], len: usize) -> ReturnCode;

    fn set_client(&self, client: &'static dyn Client);
}

pub trait Client {
    /// Called when set_addr, write or read are complete
    ///
    /// set_address does not return a buffer
    /// write and read return a buffer
    /// len should be set to the number of data elements written
    fn command_complete(&self, buffer: Option<&'static mut [u8]>, len: usize);
}
```

#### Example

Example for ST7735 screen before bus (spi dependent driver)
```rust
//! ```rust
 let tft = components::st7755::ST7735Component::new(alarm_mux).finalize(
     components::st7735_component_helper!(
         // spi type
         stm32f4xx::spi::Spi,
         // chip select
         stm32f4xx::gpio::PinId::PE03,
         // spi mux
         spi_mux,
         // timer type
         stm32f4xx::tim2::Tim2,
         // dc pin
         stm32f4xx::gpio::PinId::PA00.get_pin().as_ref().unwrap(),
         // reset pin
         stm32f4xx::gpio::PinId::PA00.get_pin().as_ref().unwrap()
     )
 );
```

Example for ST7735 screen after bus (bus dependent library)
```rust
let bus = components::bus::Bus8080BusComponent::new().finalize(
    components::bus8080_bus_component_helper!(
        // bus type
        stm32f412g::fsmc::Fsmc,
        // bus
        &stm32f412g::fsmc::FSMC
    ),
);

let tft = components::st77xx::ST77XXComponent::new(mux_alarm).finalize(
    components::st77xx_component_helper!(
        // screen
        &capsules::st77xx::ST7789H2,
        // bus type
        capsules::bus::Bus8080Bus<'static, stm32f412g::fsmc::Fsmc>,
        // bus
        &bus,
        // timer type
        stm32f412g::tim2::Tim2,
        // pin type
        stm32f412g::gpio::Pin,
        // dc pin (optional)
        None,
        // reset pin
        stm32f412g::gpio::PinId::PD11.get_pin().as_ref().unwrap()
    ),
);
```


### Testing Strategy

This pull request was tested using ST7735 and ST7789H2 screens using nano33ble and stm32f412gdiscovery


### TODO or Help Wanted

This pull request still needs some help for the FSMC. I have no idea how to make the write asynchronous, there is a FSMC interrupt but I'm not sure how to call it. One option would be DMA, but it does not seem to be available for FSMC. Any idea would be very useful, as the screen for stm32f412gdiscovery is connected the FSMC.


### Documentation Updated

- [x] Updated the relevant files in `/docs`, or no updates are required.

### Formatting

- [x] Ran `make prepush`.

## Working environment

The repository is checked out at `/app/tock` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
